Common Launch Options. With Sway most games don't grab the cursor correctly and don't allow a higher resolution then 1080p.
```
PROTON_ENABLE_WAYLAND=1 gamemoderun gamescope --force-grab-cursor -w 2560 -h 1440 -r 144 -- %command%
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

## Anno 2070

This justfile has the commands to install Ubisoft connect and run Anno 2070 from it. The game sometimes fails to start -> `killall Anno5.exe` to stop it then.

```
export STEAM_COMPAT_CLIENT_INSTALL_PATH := "~/.steam/steam"
export STEAM_COMPAT_DATA_PATH := justfile_dir()
export WINEPREFIX := justfile_dir() / "pfx"

proton_bin := home_dir() / ".steam/root/steamapps/common/Proton - Experimental/proton"

# Get installer from: https://www.ubisoft.com/de-de/ubisoft-connect
run-installer:
	"{{proton_bin}}" run {{justfile_dir()}}/UbisoftConnectInstaller.exe
	
# Run this next to install Anno 2070.
# PROTON_FORCE_WINDOWED=1 fixes weird behavior of the ubisoft connect window, but this could be due to sway
run-ubisoft:
	PROTON_FORCE_WINDOWED=1 PROTON_USE_WINED3D11=1 WINE_CPU_TOPOLOGY=4:0,1,2,3 PROTON_SET_GAME_DRIVE=1 "{{proton_bin}}" run "{{justfile_dir()}}/pfx/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/upc.exe"

# Run this to start the game. For Sway/Tiling stop Ubisoft connect first
run:
	PROTON_ENABLE_WAYLAND=1 gamescope -w 1920 -h 1080 -r 144 -- "{{proton_bin}}" run "{{justfile_dir()}}/pfx/drive_c/Program Files (x86)/Ubisoft/Ubisoft Game Launcher/upc.exe" "-uplay_silent" "uplay://launch/22/0"

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
