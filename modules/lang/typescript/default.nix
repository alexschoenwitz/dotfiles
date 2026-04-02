{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs-slim
    prettierd
  ];
}
