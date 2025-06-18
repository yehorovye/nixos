{
  home.file.".config/nushell/nu_scripts" = {
    source = fetchGit {
      url = "https://github.com/nushell/nu_scripts.git";
      rev = "b2d512f6c67f68895a26136c6ce552281efbec6e";
      ref = "main";
    };
    recursive = true;
  };
  home.file.".config/nushell/scripts".source = ./scripts;
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    shellAliases = {
      cls = "clear";
      nv = "nvim";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      bc = "bc -ql";
      grep = "grep --color=always";
    };
  };
}

