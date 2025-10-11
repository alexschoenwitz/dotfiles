{ pkgs, ... }:
{
  home.packages = [
    pkgs.zsh-autosuggestions
    pkgs.zsh-powerlevel10k
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      eval "$(direnv hook zsh)"
      export KUBECONFIG=$(find ~/.kube -maxdepth 1 -name "*" -type f | tr '\n' ':' | sed 's/:$//')
      if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        exec tmux
      fi
    '';
    shellAliases = {
      ".." = "cd ..";
    };
  };
}
