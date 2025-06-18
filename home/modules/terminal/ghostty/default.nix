{ pkgs, ... }: {
  programs.ghostty = {
    enable = false;

    settings = {
      window-padding-x = 10;
      window-padding-y = 8;
      theme = "catppuccin-mocha";
      command = "${pkgs.nushell}/bin/nu";
    };
  };
}
