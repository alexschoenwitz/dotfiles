{
  render-markdown.enable = true;
  treesitter.enable = true;
  web-devicons.enable = true;
  which-key.enable = true;
  blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "enter";
        "<CR>" = [
          "accept"
          "fallback"
        ];
        "<Tab>" = [
          "snippet_forward"
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "snippet_backward"
          "select_prev"
          "fallback"
        ];
      };
    };
  };
}
