{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.logind.settings.Login.HandlePowerKey = "ignore";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    enableHidpi = true;
    settings = {
      General = {
        GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192,XCURSOR_SIZE=48";
      };
      Theme = {
        CursorTheme = "Adwaita";
        CursorSize = 48;
      };
    };
  };

}
