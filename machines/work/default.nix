{ pkgs, user, ... }:
{
  imports = [ ../shared/darwin.nix ];

  # homebrew.casks = [
  #   "brave-browser"
  #   "visual-studio-code"
  # ];

  home-manager.users.${user.username} = {
    imports = [ ../../modules/default-user.nix ];
    home.sessionVariables = {
      SSH_KEY_PATH = "~/.ssh/id_rsa";
      DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/share/dotnet";
      PROTOC_INCLUDE = "${pkgs.protobuf}/include";
      Protobuf_ProtocFullPath = "${pkgs.protobuf}/bin/protoc";
      gRPC_PluginFullPath = "${pkgs.grpc}/bin/grpc_csharp_plugin";
    };
    programs.git.settings.user.email = "alexandre.schoenwitz@freiheit.com";
    programs.git.signing.key = "~/.ssh/id_rsa.pub";
    home.packages = [
      pkgs.claude-code
    ];
  };
}
