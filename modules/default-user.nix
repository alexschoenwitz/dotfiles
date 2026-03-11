# Default user configuration module
# Contains common imports for the primary user across all machines
# Machine-specific overrides should be set in machines/*/default.nix
{ ... }:
{
  imports = [
    ./theme/colors.nix
    ./direnv.nix
    ./ghostty
    ./git
    ./home.nix
    ./kubernetes
    ./nixvim
    ./pkgs.nix
    ./protobuf
    ./lang.nix
    ./tmux
    ./zsh
    ./ssh.nix
    ./default-user-darwin.nix
  ];
}
