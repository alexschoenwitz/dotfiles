{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-completion-sync";
        src = pkgs.fetchFromGitHub {
          owner = "BronzeDeer";
          repo = "zsh-completion-sync";
          rev = "master";
          hash = "sha256-nTxeSUlYdl25MFZoLtpYTYq661iaik1RMj21ClOMY3c=";
        };
      }
    ];

    setOptions = [
      "EXTENDED_HISTORY"
      "RM_STAR_WAIT"
      "AUTO_CD"
      "GLOB_STAR_SHORT"
      "EXTENDED_GLOB"
      "EXTENDED_GLOB"
      "AUTO_PUSHD"
      "PUSHD_MINUS"
      "PUSHD_IGNORE_DUPS"
      "PUSHD_SILENT"
    ];

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    initContent = builtins.readFile ./zshrc;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
