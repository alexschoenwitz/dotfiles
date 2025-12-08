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
  };
  programs.git = {
    enable = true;
    # userEmail is set per machine
    lfs = {
      enable = true;
    };
    settings = {
      user.name = user.fullName;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.program = "${pkgs.openssh}/bin/ssh-keygen";
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
        markIgnoredLiens = true;
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
      };
      submodule = {
        fetchJobs = 4;
      };
      rerere = {
        enabled = true;
      };
    };
    ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);
  };
}
