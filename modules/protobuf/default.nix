{ pkgs, lib, config, ... }:
{
  options.tools.protobuf.enable = lib.mkEnableOption "Protobuf and gRPC tools" // { default = true; };

  config = lib.mkIf config.tools.protobuf.enable {
    home.packages = with pkgs; [
      buf
      protobuf
      grpcui
      grpcurl
    ];
  };
}
