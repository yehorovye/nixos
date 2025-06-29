{ lib, pkgs, ... }:
{
  plugins = {
    rustaceanvim.enable = true;
    crates-nvim.enable = true;
    conform-nvim.settings = {
      formatters_by_ft = {
        rust = [ "rustfmt" ];
      };
      formatters = {
        rustfmt = {
          command = lib.getExe pkgs.rustfmt;
        };
      };
    };
  };
}
