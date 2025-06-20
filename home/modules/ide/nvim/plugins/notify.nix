{
  plugins.notify = {
    enable = true;
    autoLoad = true;
    settings = {
      background_colour = "#000000";
      fps = 60;
      icons = {
        debug = "";
        error = "";
        info = "";
        trace = "✎";
        warn = "";
      };
      level = "info";
      max_height = 10;
      max_width = 80;
      minimum_width = 50;
      render = "default";
      stages = "fade_in_slide_out";
      timeout = 3000;
      top_down = true;
    };
  };
}
