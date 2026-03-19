{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [
    asvetliakov.vscode-neovim
    zxh404.vscode-proto3
    docker.docker
  ];
}
