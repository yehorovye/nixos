{ config, ... }:
{
  home.file.".config/yazi/themes".source = ./themes;
  programs.yazi = {
    enable = true;
    theme.source = "${config.xdg.configHome}/yazi/themes/tokyonight-moon.toml";
  };
}
