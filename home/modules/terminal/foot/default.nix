{ config, ... }: {
  home.file.".config/foot/themes/catppuccin-mocha.ini".source = ./themes/catppuccin-mocha.ini;
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x10center";
        font = "JetBrainsMono Nerd Font:size=12";
        include = "${config.xdg.configHome}/foot/themes/catppuccin-mocha.ini";
      };
      scrollback = {
        lines = 100000;
      };
    };
  };
}

