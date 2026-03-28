{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dotnetCorePackages.sdk_10_0-bin
    omnisharp-roslyn
  ];
  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/share/dotnet";
  };
}
