{ pkgs, ... }:
{
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.dconf.enable = true;
  services.flatpak.enable = true;
  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "wlr" "kde" ];
      common."org.freedesktop.impl.portal.Settings" = [ "gtk" ];
    };
  };
}
