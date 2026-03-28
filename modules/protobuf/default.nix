{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.tools.protobuf.enable = lib.mkEnableOption "Protobuf and gRPC tools" // {
    default = true;
  };

  config = lib.mkIf config.tools.protobuf.enable {
    home.packages = with pkgs; [
      buf
      protobuf
      grpcui
      grpcurl
    ];
    home.sessionVariables = {
      PROTOC_INCLUDE = "${pkgs.protobuf}/include";
      Protobuf_ProtocFullPath = "${pkgs.protobuf}/bin/protoc";
      gRPC_PluginFullPath = "${pkgs.grpc}/bin/grpc_csharp_plugin";
    };
  };
}
