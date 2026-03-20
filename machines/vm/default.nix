{ lib, modulesPath, pkgs, user, ... }:
{
  imports = [
    ../shared/nixos.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  networking.hostName = "nixos-vm";

  services.lima.enable = true;

  programs.nix-ld.enable = true;

  environment.systemPackages = [ pkgs.ghostty.terminfo ];

  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };

  fileSystems."/boot" = {
    device = lib.mkForce "/dev/vda1";
    fsType = "vfat";
  };

  fileSystems."/Users/alexandre.schoenwitz" = {
    device = "mount0";
    fsType = "virtiofs";
  };

  home-manager.users.${user.username} = {
    imports = [ ../../modules/default-user.nix ];
    home.sessionVariables = {
      SSH_KEY_PATH = "~/.ssh/id_ed25519";
      DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/share/dotnet";
      PROTOC_INCLUDE = "${pkgs.protobuf}/include";
      Protobuf_ProtocFullPath = "${pkgs.protobuf}/bin/protoc";
      gRPC_PluginFullPath = "${pkgs.grpc}/bin/grpc_csharp_plugin";
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
    programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
    programs.git.signing.key = "~/.ssh/id_ed25519.pub";
    home.packages = with pkgs; [
      claude-code
      awscli2
      dotnetCorePackages.sdk_10_0-bin
      envsubst
      flutter
      just
      jwt-cli
      lcov
      openfga-cli
      protoc-gen-dart
      yq
    ];
  };
}
