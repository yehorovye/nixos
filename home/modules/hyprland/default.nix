{ pkgs, ... }:

let
  wallpaperScript = pkgs.writeShellScriptBin "random-wallpaper" ''
    WALP=$(find "$HOME/Pictures/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    [ -n "$WALP" ] && ${pkgs.swww}/bin/swww img --transition-type wipe --transition-angle 30 "$WALP"
  '';
  startupScript = pkgs.writeShellScriptBin "start" ''
    # start swww daemon
    ${pkgs.swww}/bin/swww-daemon &

    # wait for swww to initialize so we change the wallpaper right away
    sleep 1
    ${wallpaperScript}/bin/random-wallpaper
  '';
in
{
  home.packages = [ wallpaperScript ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",1920x1080,auto,1,bitdepth,8"
        ",preferred,auto,1,mirror,eDP-1,bitdepth,8"
      ];

      xwayland = {
        force_zero_scaling = "true";
      };

      "$term" = "alacritty";
      "$browser" = "zen";
      "$menu" = "wofi --show drun";
      "$discord" = "discord";

      exec-once = [ "${startupScript}/bin/start" ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,20"
      ];

      general = {
        gaps_in = "5";
        gaps_out = "20";
        border_size = "1";
        "col.active_border" = "rgb(4c4f69) 45deg";
        "col.inactive_border" = "rgb(6c7086)";
        resize_on_border = "false";
        allow_tearing = "false";
        layout = "dwindle";
      };

      decoration = {
        rounding = "0";
        active_opacity = "0.95";
        inactive_opacity = "0.8";
        shadow.enabled = false;
        blur = {
          enabled = true;
          xray = false;
          special = true;
          new_optimizations = true;
          size = 10;
          passes = 3;
          brightness = 0.9;
          noise = 2.0e-2;
          contrast = 1.1;
          popups = true;
          popups_ignorealpha = 0.5;

          # Experimental tweaks (if supported by your Hyprland version)
          vibrancy = 0.2;
          vibrancy_darkness = 0.1;
        };
      };

      blurls = "waybar"; # i don't have waybar but i keep this here just in case.
      layerrule = "blur,waybar";

      animations = {
        enabled = "true";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      misc = {
        force_default_wallpaper = "0";
        disable_hyprland_logo = "true";
        middle_click_paste = "false";
        vfr = "true";
      };

      gestures.workspace_swipe = "false";

      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.5";
      };

      "$mainMod" = "SUPER";

      bind = [
        ", PRINT, exec, nu ~/bin/tixte.nu"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, PRINT, exec, nu ~/bin/tixte.nu --slurp"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, T, exec, $term"
        "$mainMod, Z, exec, $browser"
        "$mainMod, D, exec, $discord"
        "$mainMod, Q, killactive"
        "$mainMod, W, exec, random-wallpaper"
        "$mainMod SHIFT, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      input = {
        kb_layout = "es,ru";
        kb_options = "grp:alt_space_toggle";
        numlock_by_default = true;
      };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrulev2 = "suppressevent maximize, class:.*";
    };
  };
}
