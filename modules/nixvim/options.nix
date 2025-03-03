{ lib, ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";

    highlight = {
      StatusLine = {
        link = "StatusLineNC";
      };
      Comment = {
        fg = "#a89984"; # gruvbox fg4 - brighter grey
        italic = true;
      };
    };

    diagnostic = {
      settings = {
        virtual_text = {
          source = "if_many";
        };
      };
    };

    opts = {
      termguicolors = lib.mkForce true;
      statusline = " %{mode()} | %f%m%r %=%l:%c %p%% ";
      undofile = true;
      number = true;
      relativenumber = false;
      statuscolumn = "%s %l %=%r ";
      signcolumn = "yes";
      ignorecase = true;
      smartcase = true;
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;
      cursorline = true;
      clipboard = "unnamedplus";
      ruler = true;
      gdefault = true;
      scrolloff = 5;
      showmode = false;
      linebreak = true;
      breakindent = true;
      fillchars = {
        diff = "╱";
        eob = " ";
      };
    };

  };
}
