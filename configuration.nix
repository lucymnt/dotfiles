{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system
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

  environment.sessionVariables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    XDG_DATA_DIRS = [
      "/run/current-system/sw/share"
      "/etc/profiles/per-user/lucyst/share"
    ];
  };
  gtk.iconCache.enable = true;
  catppuccin = {
    enable = true;
    autoEnable = false;
    limine.enable = true;
  };
  system.stateVersion = "25.11";
}
