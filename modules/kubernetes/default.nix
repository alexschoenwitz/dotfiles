{ pkgs, lib, config, ... }:
{
  options.tools.kubernetes.enable = lib.mkEnableOption "Kubernetes tools" // { default = true; };

  config = lib.mkIf config.tools.kubernetes.enable {
    home.packages = with pkgs; [
      kubectl
      k9s
      istioctl
      skaffold
      kind
    ];
  };
}
