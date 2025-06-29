{
  pkgs,
  config,
  inputs,
  ...
}:
{
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    extraModulePackages = with config.boot.kernelPackages; [
      rtl88xxau-aircrack
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = null;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "2715x1527"; # for 4k: 3840x2160
        gfxmodeBios = "2715x1527"; # for 4k: 3840x2160
        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Networking and downloads
    curl
    git
    git-credential-manager
    wget
    unzip

    # CLI utilities
    just

    # Wayland utilities
    grim
    libnotify
    slurp
    swww
    pavucontrol
    wl-clipboard
    thunderbird

    # games
    xonotic

    # cursor
    bibata-cursors

    # External packages
    inputs.zen-browser.packages.${system}.default
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
