{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    initExtra = "source ~/.p10k.zsh";
  };
}
