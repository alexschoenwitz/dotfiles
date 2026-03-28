{
  pkgs,
  lib,
  config,
  ...
}:
{
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
}
