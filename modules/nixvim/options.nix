{
  programs.nixvim = {
    globals.mapleader = " ";
    opts = {
      undofile = true;
      number = true;
      relativenumber = true;
      statuscolumn = "%s %l %=%r ";
      signcolumn = "yes";
      ignorecase = true;
      smartcase = true;
      tabstop = 4;
      shiftwidth = 4;
      foldcolumn = "4";
      softtabstop = 0;
      expandtab = true;
      smarttab = true;
      cursorline = true;
      clipboard = "unnamedplus";
      ruler = true;
      gdefault = true;
      scrolloff = 5;
      autochdir = true;
      showmode = false; # Already have a statusline
      fillchars = {
        foldopen = "";
        foldclose = "";
        fold = " ";
        foldsep = " ";
        diff = "╱";
        eob = " ";
      };
    };

    colorschemes.gruvbox.enable = true;
  };
}
