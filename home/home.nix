{
  imports = [
    ./modules/git.nix
    ./modules/packages.nix
    ./modules/dunst.nix
    ./modules/obs.nix
    ./modules/wofi/default.nix

    # wayland
    ./modules/hyprland/default.nix

    # terminals
    ./modules/terminal/foot/default.nix
    ./modules/terminal/ghostty/default.nix # disabled LLLLL
    ./modules/terminal/alacritty/default.nix

    # ides
    ./modules/ide/nvim/default.nix

    # shell stuff
    ./modules/shell/bash/default.nix
    ./modules/shell/nushell/default.nix

    # nix env
    ./modules/env/direnv/default.nix
    ./modules/env/devenv/default.nix
  ];

  home.username = "ye";
  home.homeDirectory = "/home/ye";
  home.stateVersion = "25.05";

  # workaround
  nixpkgs.config.allowUnfreePredicate = _: true;

  programs.home-manager.enable = true;
}
