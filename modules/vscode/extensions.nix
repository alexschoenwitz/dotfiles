{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [
    asvetliakov.vscode-neovim
    redhat.vscode-xml
    zxh404.vscode-proto3
    docker.docker
  ];
}
