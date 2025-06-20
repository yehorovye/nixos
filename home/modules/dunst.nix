{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        offset = "15x15";
        corner_radius = 0;
        transparency = 50;
        frame_width = 1;
        timeout = 3;
        font = "JetBrainsMono Nerd Font 10";
        icon_corner_radius = 0;
        min_icon_size = 56;
      };

      urgency_low = {
        background = "#1e2030";
        foreground = "#c8d3f5";
        frame_color = "#c8d3f5";
        timeout = 3;
      };

      urgency_normal = {
        background = "#222436";
        foreground = "#c8d3f5";
        frame_color = "#c8d3f5";
        timeout = 3;
      };

      urgency_critical = {
        background = "#2f334d";
        foreground = "#c53b53";
        frame_color = "#c53b53";
        timeout = 5;
      };
    };
  };
}
