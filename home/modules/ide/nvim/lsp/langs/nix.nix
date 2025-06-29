{
  plugins = {
    lsp.servers = {
      nixd = {
        enable = true;
        cmd = [ "nixd" ];
        rootMarkers = [
          "require('lspconfig.util').root_pattern('.nixd.json', 'flake.nix', '.git')"
        ];
      };
    };
  };
}
