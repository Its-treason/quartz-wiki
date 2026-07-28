Common Launch Options. With Sway most games don't grab the cursor correctly and don't allow a higher resolution then 1080p.
```
PROTON_ENABLE_WAYLAND=1 gamemoderun gamescope --force-grab-cursor -w 2560 -h 1440 -f -r 144 -- %command%
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

