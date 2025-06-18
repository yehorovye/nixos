{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        offset = "15x15";
        corner_radius = 7;
        transparency = 30;
        frame_width = 1;
        timeout = 3;
        font = "JetBrainsMono Nerd Font 9";
        foreground = "#cdd6f4";
        background = "#181825";
        icon_corner_radius = 5;
      };

      urgency_low = {
        frame_color = "#a6e3a1";
        timeout = 3;
      };

      urgency_normal = {
        frame_color = "#94e2d5";
        timeout = 3;
      };

      urgency_critical = {
        frame_color = "#f38ba8";
        timeout = 5;
      };
    };
  };
}

