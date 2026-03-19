{ lib, modulesPath, pkgs, user, ... }:
{
  imports = [
    ../shared/nixos.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  networking.hostName = "nixos-vm";

  services.lima.enable = true;

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
    home.sessionVariables.SSH_KEY_PATH = "~/.ssh/id_ed25519";
    programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
    programs.git.signing.key = "~/.ssh/id_ed25519.pub";
    home.packages = [ pkgs.claude-code ];
  };
}
