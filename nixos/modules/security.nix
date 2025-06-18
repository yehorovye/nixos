{ pkgs, ... }:

{
  users.users.ye = {
    isNormalUser = true;
    description = "Elisiei Yeherov";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
    shell = pkgs.nushell;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "ye";
      };
      default_session = initial_session;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
}
