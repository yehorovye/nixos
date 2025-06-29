{ pkgs, inputs, ... }:

# My most preciated config, well documented if you want to use it.
# Inspired by https://github.com/XhuyZ/nixvim

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  # ──────────────────────────────────────────────────────────────────────────
  # 1.  Enable nixvim
  # ──────────────────────────────────────────────────────────────────────────
  programs.nixvim = {
    enable = true;

    # ────────────────────────────────────────────────────────────────────────
    # 2.  Import all the small, plugin‑scoped modules that came from the flake
    # ────────────────────────────────────────────────────────────────────────
    imports = [
      # Plugins
      ./plugins/aerial.nix
      ./plugins/autopairs.nix
      ./plugins/blink.nix
      ./plugins/bufferline.nix
      ./plugins/cord.nix
      ./plugins/dashboard.nix
      ./plugins/hlchunk.nix
      ./plugins/lazygit.nix
      ./plugins/lualine.nix
      ./plugins/neoscroll.nix
      ./plugins/noice.nix
      ./plugins/notify.nix
      ./plugins/smear-cursor.nix
      ./plugins/snacks.nix
      ./plugins/tmux-navigator.nix
      ./plugins/toggleterm.nix
      ./plugins/treesitter.nix
      ./plugins/treesj.nix
      ./plugins/wakatime.nix
      ./plugins/web-devicons.nix
      ./plugins/yanky.nix
      ./plugins/yazi.nix

      # LSP
      ./lsp/fidget.nix
      ./lsp/lsp.nix
      ./lsp/roslyn.nix

      # Keymaps
      ./keymaps.nix

      # Themes
      ./themes.nix
    ];

    # ────────────────────────────────────────────────────────────────────────
    # 3.  The global settings that were in the old flake’s `config/default.nix`
    # ────────────────────────────────────────────────────────────────────────
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      colorcolumn = "80";
      shiftwidth = 2;
      tabstop = 2;
      wrap = false;
      swapfile = false; # Undotree
      backup = false; # Undotree
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
      foldlevelstart = 99;
    };

    clipboard = {
      register = "unnamedplus";
    };

    extraPackages = with pkgs; [
      # Fonts & fuzzy finders
      fzf
      ripgrep
      fd

      # Formatters
      stylua
      csharpier
      nixfmt-rfc-style

      # Linters
      golangci-lint
      shellcheck
      eslint_d

      # Debuggers / LSP helpers
      netcoredbg
      asm-lsp
      bashdb
      delve

      # Wakatime
      wakatime-cli
    ];

    extraConfigLua = ''
      			vim.o.undofile = true
      			vim.o.undodir = vim.fn.expand("~/.local/state/nvim/undo")
      		'';
  };
}
