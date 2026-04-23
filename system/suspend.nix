{ config, pkgs, ... }:
let
  hyprlockHook = pkgs.writeShellScript "hyprlock-hook" ''
    if [ "$1" = "pre" ]; then
        systemctl thaw user.slice
        /run/wrappers/bin/sudo -u lucyst \
          WAYLAND_DISPLAY=wayland-0 \
          XDG_RUNTIME_DIR=/run/user/1000 \
          DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
          ${pkgs.hyprlock}/bin/hyprlock &
        timeout=100
        timeout=100
         while [ $timeout -gt 0 ]; do
             if ${pkgs.systemd}/bin/journalctl -n 30 --no-pager -q | ${pkgs.gnugrep}/bin/grep -q "Locking session"; then
                 ${pkgs.coreutils}/bin/sleep 1
                 break
             fi
             ${pkgs.coreutils}/bin/sleep 0.1
             ((timeout--))
         done
    fi
  '';
in
{
  system.activationScripts.hyprlockSleepHook = {
    text = ''
      mkdir -p /etc/systemd/system-sleep
      ln -sf ${hyprlockHook} /etc/systemd/system-sleep/hyprlock-hook
    '';
  };

  security.pam.services.hyprlock = {};
}
