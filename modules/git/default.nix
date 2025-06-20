{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ git-lfs ];
  programs.ssh = {
    enable = true; # Ensure programs.ssh is enabled for extraConfig to apply
    extraConfig = ''
      Host *
        UseKeychain yes
        AddKeysToAgent yes
    '';
  };
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Alexandre Schönwitz";
    # userEmail is set per machine
    lfs = {
      enable = true;
    };
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.program = "${pkgs.openssh}/bin/ssh-keygen";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
      core = {
        editor = "nvim";
        compression = -1;
        autocrlf = "input";
        whitespace = "trailing-space,space-before-tab";
        precomposeunicode = true;
      };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };
      advice = {
        addEmptyPathspec = false;
      };
      apply = {
        whitespace = "nowarn";
      };
      help = {
        autocorrect = 1;
      };
      grep = {
        extendRegexp = true;
        lineNumber = true;
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      submodule = {
        fetchJobs = 4;
      };
      log = {
        showSignature = false;
      };
      format = {
        signOff = true;
      };
      rerere = {
        enabled = true;
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
    ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);
  };
}
