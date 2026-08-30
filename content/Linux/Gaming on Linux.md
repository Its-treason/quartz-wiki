Common Launch Options. With Sway most games don't grab the cursor correctly and don't allow a higher resolution then 1080p.
```
PROTON_ENABLE_WAYLAND=1 gamemoderun gamescope --force-grab-cursor -w 2560 -h 1440 -f -r 144 -- %command%
```

Justfile for non Steam installs
```
export STEAM_COMPAT_CLIENT_INSTALL_PATH := "~/.steam/steam"
export STEAM_COMPAT_DATA_PATH := justfile_dir()
export WINEPREFIX := justfile_dir() / "pfx"

proton_bin := home_dir() / ".steam/root/steamapps/common/Proton - Experimental/proton"

run-installer:
	"{{proton_bin}}" run {{justfile_dir()}}/...Installer.exe
	

run:
	"{{proton_bin}}" run "{{justfile_dir()}}/pfx/drive_c/...."


# Debug
run-regedit:
	wine regedit

run-wine +CMD:
	wine {{CMD}}

run-winecfg:
	winecfg

printenv:
    printenv
```


# Troubleshooting
## Long "Processing Vulkan Shaders"

Update `~/.steam/steam/steam_dev.cfg` add `unShaderBackgroundProcessingThreads X` replace X with the core count of your CPU.

```bash
$ echo "unShaderBackgroundProcessingThreads $(nproc)" >> ~/.steam/steam/steam_dev.cfg
```


# Game configs
## Hunt Showdown
**Proton** `GE-Proton11-1`
**Launch Options**
```
PROTON_ENABLE_WAYLAND=1 gamemoderun gamescope --force-grab-cursor -w 2560 -h 1440 -f -r 144 -- %command%
```
**Notes**
With Proton Experimental and `gamescope` i had a problem where the keyboard input did not work. 

## Mass Effect Legendary Edition
**Proton** `GE-Proton11-1`
**Launch Options**
```
PROTON_ENABLE_WAYLAND=1 gamemoderun gamescope --force-grab-cursor -w 2560 -h 1440 -f -r 144 -- %command%
```
**Notes**
This is one of the game where the mouse is not grabbed

