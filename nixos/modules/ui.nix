{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Nerd Font" ];
      sansSerif = [ "Noto Nerd Font" ];
      monospace = [ "Noto Nerd Font" ];
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      beautifulLyrics
      hidePodcasts
    ];
    colorScheme = "Ocean";
  };
}
