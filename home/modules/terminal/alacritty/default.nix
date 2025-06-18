{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "normal";
        };
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
    theme = "catppuccin_mocha";
  };
}
