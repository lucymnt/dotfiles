{ config, pkgs, lib, ... }:
let
  themeName = "rose-pine";
  roseGtk = pkgs.rose-pine-gtk-theme;
in
{
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style = {
      name = "Darkly";
      package = pkgs.darkly;
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = themeName;
      package = roseGtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.theme = null;
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = themeName;
      icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
    };
  };
  home.sessionVariables = {
    GIO_EXTRA_MODULES = "${pkgs.dconf.lib}/lib/gio/modules:${pkgs.gvfs}/lib/gio/modules";
  };
  xdg.configFile = {
    "gtk-4.0/gtk.css".source = "${roseGtk}/share/themes/${themeName}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${roseGtk}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
    "gtk-4.0/assets" = {
      source = "${roseGtk}/share/themes/${themeName}/gtk-4.0/assets";
      recursive = true;
    };
    "xdg-desktop-portal/mango-portals.conf".text = ''
    [preferred]
    default=wlr;kde
    org.freedesktop.impl.portal.Settings=gtk
    org.freedesktop.impl.portal.ScreenCast=wlr
    org.freedesktop.impl.portal.Screenshot=wlr
    '';
    "kdeglobals".text = ''
      [General]
      ColorScheme=CatppuccinMochaMauve
      TerminalApplication=foot
      [UiSettings]
      ColorScheme=CatppuccinMochaMauve
    '';
  };
  xdg.dataFile = {
    "color-schemes".source = ../dotfiles/color-schemes;
  };
}
