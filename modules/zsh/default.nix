{ pkgs, ... }:
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
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
    ];

    shellAliases = {
      l = "eza";
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";
      cat = "bat";
      urldecode = "python3 -c \"import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))\"";
      urlencode = "python3 -c \"import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))\"";

      # git - core
      gs = "git status";
      gss = "git switch";
      gsss = "git switch -c";
      gt = "git log --all --graph --decorate --oneline";
      gf = "git fetch";

      gd = "git diff";
      gdd = "git diff --staged";
      gddd = "git diff ...origin/main";

      gsh = "git show";

      gp = "git push";
      gl = "git pull --rebase";
      gr = "git restore";
      grr = "git restore --staged";

    };

    setOptions = [
      "EXTENDED_HISTORY"
      "RM_STAR_WAIT"
      "AUTO_CD"
      "GLOB_STAR_SHORT"
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

  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "plain";
      theme = "base16";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 2000;
      format = "$directory$git_branch$git_status$cmd_duration$character";
      cmd_duration = {
        min_time = 2000;
        format = "[$duration]($style) ";
      };
      directory.truncation_length = 3;
      git_branch.format = "[$branch]($style) ";
      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        stashed = "";
      };
      character = {
        success_symbol = "[%](bold green)";
        error_symbol = "[%](bold red)";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  home.sessionVariables._ZO_DOCTOR = 0;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
