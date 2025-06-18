{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # Modules
    ./modules/core.nix
    ./modules/locale.nix
    ./modules/security.nix
    ./modules/ui.nix
    ./modules/hardware.nix

    inputs.spicetify-nix.nixosModules.default
  ];

  systemd.tmpfiles.rules = [ "L+ /usr/local/bin - - - - /run/current-system/sw/bin/" ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  system.stateVersion = "25.05";
}
