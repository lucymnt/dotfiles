{ config, pkgs, ... }
{ 
  systemd.services."hyprlock-before-sleep" = {
    description = "Lock screen with hyprlock before suspend";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "lucyst";  # run as your user
      Environment = [
        "WAYLAND_DISPLAY=wayland-0"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
    ExecStartPre = "${pkgs.systemd}/bin/systemctl thaw user.slice";
    ExecStart = pkgs.writeShellScript "hyprlock-lock" ''
      ${pkgs.hyprlock}/bin/hyprlock &
      timeout=50
      while [ $timeout -gt 0 ]; do
        if journalctl -n 20 --no-pager -q | grep -q "Locking session"; then
          break
        fi
        sleep 0.1
        ((timeout--))
      done
    '';
    };
  }; 
}
