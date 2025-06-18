{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    jq
    btop
    zig
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
