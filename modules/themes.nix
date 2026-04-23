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
      name = "PapirusDarkCustom";
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "rose-pine";
      icon-theme = "PapirusDarkCustom";
      color-scheme = "prefer-dark";
    };
  };

  home.sessionVariables = {
    GTK_THEME = themeName;
    GIO_EXTRA_MODULES = "${pkgs.dconf.lib}/lib/gio/modules:${pkgs.gvfs}/lib/gio/modules";
  };

  xdg.configFile = {
    "gtk-4.0/gtk.css".source = "${roseGtk}/share/themes/${themeName}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${roseGtk}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
    "gtk-4.0/assets" = {
      source = "${roseGtk}/share/themes/${themeName}/gtk-4.0/assets";
      recursive = true;
    };
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

    "icons/PapirusDarkCustom/index.theme".text = ''
      [Icon Theme]
      Name=PapirusDarkCustom
      Comment=Papirus Dark with custom icons
      Inherits=Papirus-Dark
      Directories=22x22/apps,22x22@2/apps,22x22/actions,22x22@2/actions

      [22x22/apps]
      Size=22
      Type=Fixed

      [22x22@2/apps]
      Size=22
      Scale=2
      Type=Fixed

      [22x22/actions]
      Size=22
      Type=Fixed

      [22x22@2/actions]
      Size=22
      Scale=2
      Type=Fixed
    '';

    "icons/PapirusDarkCustom/22x22/apps/drive-multidisk.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/devices/drive-multidisk.svg";
    "icons/PapirusDarkCustom/22x22/apps/drive-multidisk-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/devices/drive-multidisk.svg";
    "icons/PapirusDarkCustom/22x22@2/apps/drive-multidisk.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/devices/drive-multidisk.svg";
    "icons/PapirusDarkCustom/22x22@2/apps/drive-multidisk-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/devices/drive-multidisk.svg";
    "icons/PapirusDarkCustom/22x22/apps/system-users.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/contact-new.svg";
    "icons/PapirusDarkCustom/22x22/apps/system-users-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/contact-new.svg";
    "icons/PapirusDarkCustom/22x22@2/apps/system-users.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/contact-new.svg";
    "icons/PapirusDarkCustom/22x22@2/apps/system-users-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/contact-new.svg";
    "icons/PapirusDarkCustom/22x22/actions/swaync-close-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/window-close.svg";
    "icons/PapirusDarkCustom/22x22/actions/swaync-collapse-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/pan-up.svg";
    "icons/PapirusDarkCustom/22x22/actions/swaync-down-small-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/pan-down.svg";
    "icons/PapirusDarkCustom/22x22/actions/swaync-up-small-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/22x22/actions/pan-up.svg";
  };
}
