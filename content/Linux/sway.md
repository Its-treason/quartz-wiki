## Autostart and assign apps to workspace

Use `swaymsg -t get_tree` to get all windows and their identifiers. Prefer using `app_id` over `class` over anything else.

```
$ swaymsg -t get_tree
#1: root "root"
  #2147483647: output "__i3"
    #2147483646: workspace "__i3_scratch"
  #5: output "HDMI-A-1"
    #18: workspace "2"
      #19: con "Mozilla Firefox" (xdg_shell, pid: 5974, app_id: "firefox", foreign_toplevel_id: "")
  #4: output "DP-2"
    #8: workspace "3"
      #9: con "~> vim" (xdg_shell, pid: 1053, app_id: "Alacritty", foreign_toplevel_id: "")
  #3: output "DP-1"
    #11: workspace "10"
      #17: con "(null)"
        #14: con "Spotify Premium" (xwayland, pid: 1528, instance: "spotify", class: "Spotify", X11 window: 0x400004, foreign_toplevel_id: "")
      #16: con "Discord" (xdg_shell, pid: 1761, app_id: "discord", foreign_toplevel_id: "")
```

Example for firefox and spotify

```
# Assign window with app_id "firefox" to workspace 2. This will only happen when windows opens.
# Note that it uses contains for the check, so this also matches for firefox-nightly, use "^firefox$" to prevent this.
assign [app_id="firefox"] workspace number 2
# Auto start app by .desktop name
exec gtk-launch firefox

assign [app_id="Spotify"] workspace number 10
exec gtk-launch spotify-launcher
```
