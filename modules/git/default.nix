{
  pkgs,
  lib,
  user,
  ...
}:
{
  home.packages = with pkgs; [ git-lfs ];

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      syntax-theme = "base16";
      side-by-side = true;
    };
  };

  programs.git = {
    enable = true;
    # userEmail and signing.key are set per machine
    lfs = {
      enable = true;
    };
    signing = {
      signByDefault = true;
      format = "ssh";
    };
    settings = {
      user.name = user.fullName;
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
      advice = {
        addEmptyPathspec = false;
      };
      apply = {
        whitespace = "nowarn";
      };
      blame = {
        coloring = "repeatedLines";
        markUnblamables = true;
        markIgnoredLines = true;
      };
      branch = {
        sort = "-committerdate";
      };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };
      core = {
        editor = "nvim";
        compression = -1;
        autocrlf = "input";
        whitespace = "trailing-space,space-before-tab";
        precomposeunicode = true;
      };
      help = {
        autocorrect = "immediate";
      };
      fetch = {
        prune = true;
        pruneTags = true;
        output = "compact";
        parallel = 0;
      };
      format = {
        signOff = true;
      };
      grep = {
        extendRegexp = true;
        lineNumber = true;
      };
      init = {
        defaultBranch = "main";
      };
      log = {
        showSignature = false;
      };
      pull = {
        ff = "only";
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
        followTags = true;
      };
      submodule = {
        fetchJobs = 4;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      rerere = {
        enabled = true;
      };
      column = {
        ui = "auto";
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        renames = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      commit = {
        verbose = true;
      };
    };
    ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);
  };
}
