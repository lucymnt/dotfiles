{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/core
    ./system/packages.nix
    ./system/nvidia.nix
    ./system/display.nix
    ./system/networking.nix
   # ./system/suspend.nix
    ./system/locale.nix
  ];
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "mango-nix";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  users.users.lucyst = {
    isNormalUser = true;
    description = "lucy";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };

  fileSystems."/mnt/neon" = {
    device = "/dev/disk/by-uuid/070ae1f3-9b9c-43f0-8011-d92359fb46d5";
    fsType = "ext4";
    options = [ "nofail" "defaults" ];
  };
  environment.sessionVariables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/mnt/neon/home/lucymn/.local/share/Steam/compatibilitytools.d:/mnt/neon/home/lucymn/.steam/root/compatibilitytools.d";
    XDG_DATA_DIRS = [
      "/run/current-system/sw/share"
      "/etc/profiles/per-user/lucyst/share"
    ];
  };
  gtk.iconCache.enable = true;
  catppuccin.limine.enable = true;
  system.stateVersion = "25.11";
}
