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
    ];
    config = {
      wlroots = {
        default = [ "wlr" "kde" ];
        };
      };
    };
}
