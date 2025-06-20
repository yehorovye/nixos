{ config, ... }:
{
  home.file.".config/alacritty/themes".source = ./themes;
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "${config.xdg.configHome}/alacritty/themes/tokyonight-moon.toml"
        ];
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "normal";
        };
      };
    };
  };
}
