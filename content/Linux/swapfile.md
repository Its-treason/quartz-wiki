Create a swapfile

```
# Not needed, but prefer swapfile in root dir
cd /
# replace <Size> if size in GB. Should be a little more than RAM size
sudo dd if=/dev/zero of=swapfile bs=1K count=<Size>M
# Set recommended permissions
sudo chmod 0600 swapfile
```

Enable swapfile

```
# Create a swapfs in the file
sudo mkswap swapfile
# Enable swapfile
sudo swapon swapfile
```

Set "swapiness". Value between 100 and 0 determining how aggressive ram should be moved to swap.
- 0 -> Disable swapfile
- 10-15 -> Recommended for system with less memory
- 100 -> Swap ram to swap aggressively

Show current swapiness
```
cat /proc/sys/vm/swappiness
```

Update swapiness on the running system 

```
sudo sysctl vm.swappiness=<Value>
```

Persist setting in `/etc/sysctl.conf` or in `/etc/sysctl.d/*.conf` with

```
vm.swappiness = <Value>
```
