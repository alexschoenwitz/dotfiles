{ user, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = user.fullName;
        # email is set per-machine
      };
      ui = {
        editor = "nvim";
        pager = "delta";
        diff.tool = [
          "delta"
          "--color-only"
        ];
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        # key is set per-machine
      };
    };
  };
}
