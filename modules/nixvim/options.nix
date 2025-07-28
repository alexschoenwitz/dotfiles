{ lib, ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";

    highlight = {
      StatusLine = {
        link = "StatusLineNC";
      };
    };

    diagnostic = {
      settings = {
        virtual_lines = {
          current_line = true;
        };
        virtual_text = false;
      };
    };

    opts = {
      termguicolors = lib.mkForce false;
      statusline = " %{mode()} | %f%m%r %=%l:%c %p%% ";
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

  };
}
