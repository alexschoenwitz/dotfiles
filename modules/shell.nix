{ ... }: {
  imports = [
    ./fish
    ./starship.nix
    ./lsd.nix
    ./bat.nix
  ];

  programs.zoxide.enable = true;
}
