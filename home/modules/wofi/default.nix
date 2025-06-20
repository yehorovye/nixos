{
  programs.wofi = {
    enable = true;
    style = ./wofi.css;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      term = "alacritty";
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      columns = 2;
    };
  };
}
