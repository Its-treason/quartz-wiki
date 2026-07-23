## Structure

Values are separated by one or more spaces.

|   |   |
|---|---|
|Name|Value|
|Filesystem|The Filesystem / Partition to be mounted.<br><br>Can be a the path to a partition e.g. `/dev/sdb2` or a UUID e.g. `PARTUUID=65561b67-2aee-4c48-8a67-2ea71f5f4ba`|
|Mount Point|Path to the mountpoint. Should be an existing empty folder. Value `none` can be used for Swap-Partitions|
|FS-Type|Type of the file system e.g `ext4` or `ntfs`|
|Options|Mounting options. e.g. `defaults,nofail` -> Default settings, allow booting when mounting the partition fails|
|Dump|Weather to create a Dump before mounting. `0` don't create dump. `1` create dump|
|Check Fsck|Check file system before mounting them. `0` don't check anything should be used for Windows / NTFS Partitions. `1` For root file system (Except if type is `btfs`or `XFS`). `2` Check the filesystem before mounting.|

Example `fstab` file:

# This is the default fstab of a rpi with an external harddrive

```
proc            /proc           proc    defaults          0       0
PARTUUID=0a70b801-01  /boot           vfat    defaults,flush    0       2
PARTUUID=0a70b801-02  /               ext4    defaults,noatime  0       1
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that

PARTUUID=6b8fd307-ae27-4222-b81c-926eaa800dbc /data ext4 defaults,nofail 0 2
# Bind mount example
/mnt/hdd/Desktop /home/timon/Desktop none bind,nofail 0 0
```

## Options

For all list of all options, see: [Ext file system options](https://man.archlinux.org/man/ext4.5#MOUNT_OPTIONS) and [File system independent Options](https://man.archlinux.org/man/mount.8#FILESYSTEM-INDEPENDENT_MOUNT_OPTIONS). Note that changing owner or permissions is only really needed for file system that don't support UNIX permissions, e.g `NTFS`. `ext4` and others will save all permissions.

|   |   |
|---|---|
|Name|Description|
|defaults|Commen Default settings. These include: `rw`,`suid`,`dev`,`exec`,`auto`,`nouser`,`async`,`realtime`|
|ro|Mount the file system in readonly mode|
|rw|Mount the file system in Read-Write mode (In defaults)|
|nofail|Skip the file system if it can't be found. Very usefull for thumb-drives. If this options is not set, the system will wait for the filesystem to be connected before booting|
|umask=PERMS|Set the Permissions for all files and directories. Important: This is a umask so its disallows permissions e.g. `000` becomes `777`, `022`becomes`755`.|
|uid=UID|Set the owner of all files. Can be the users UID or username.|
|gid=GID|Set the owner group of all files. Can be the groups GID or groupname.|
|windows_names|Only for NTFS: Prevent the creating of files with characters that are not allowed within Windows e.g. `" * < > / \| \` and some|

## Determine file system types and UUID

To list all partitions with their UUID execute:

sudo blkid -s UUID

## Validating fstab

Executing `mount -fav` will try to mount all file systems without actually making a system call.

- `-a` Try to auto mount everything inside `fstab`.
- `-f` Fake, don't make any system calls.
- `-v` Verbose print more debug output.

Alternative `findmnt --verify --verbose` can print nice information and detailed error messages.

Output without any errors:
``
```
# findmnt --verify --verbose
/proc
   [ ] target exists
   [ ] do not check proc source (pseudo/net)
   [ ] do not check proc FS type (pseudo/net)
/boot
   [ ] target exists
   [ ] FS options: flush
   [ ] PARTUUID=0a70b801-01 translated to /dev/mmcblk0p1
   [ ] source /dev/mmcblk0p1 exists
   [ ] FS type is vfat
/
   [ ] target exists
   [ ] VFS options: noatime
   [ ] PARTUUID=0a70b801-02 translated to /dev/mmcblk0p2
   [ ] source /dev/mmcblk0p2 exists
   [ ] FS type is ext4
/data
   [ ] target exists
   [ ] userspace options: nofail
   [ ] PARTUUID=6b8fd307-ae27-4222-b81c-926eaa800dbc translated to /dev/sda1
   [ ] source /dev/sda1 exists
   [ ] FS type is ext4
Success, no errors or warnings detected
```

Output with wrong `PARTUUID` value:

```
# findmnt --verify --verbose
/proc
   [ ] target exists
...
   [ ] source /dev/mmcblk0p2 exists
   [ ] FS type is ext4
/data
   [ ] target exists
   [ ] userspace options: nofail
   [E] unreachable on boot required source: PARTUUID=6b8fd307-ae27-4222-b81c-926eaa800db

0 parse errors, 1 error, 0 warnings
```
