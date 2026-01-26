# Default user configuration module
# Contains common imports for the primary user across all machines
# Machine-specific overrides should be set in machines/*/default.nix
{ ... }:
{
  imports = [
    ./aerospace
    ./colima.nix
    ./direnv.nix
    ./ghostty
    ./git
    ./home.nix
    ./nixvim
    ./pkgs.nix
    ./lang.nix
    ./tmux
    ./vscode
    ./zsh
    ./ssh.nix
  ];
}
