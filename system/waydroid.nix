{ config, lib, pkgs, ... }:
let
  intelRenderNode = "/dev/dri/by-path/pci-0000:00:02.0-render";
in
{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  systemd.services.waydroid-container = {
    serviceConfig = {
      Delegate = true;
      CPUAccounting = true;
      MemoryAccounting = true;
      TasksAccounting = true;
      ExecStartPre = lib.mkAfter [
        (pkgs.writeShellScript "waydroid-gpu-fix-pre" ''
          set -e
          PROP_FILE="/var/lib/waydroid/waydroid.prop"
          mkdir -p /var/lib/waydroid
          touch "$PROP_FILE"
          chown root:root "$PROP_FILE"
          chmod 644 "$PROP_FILE"

          set_prop() {
            ${pkgs.gnused}/bin/sed -i "/^$1=/d" "$PROP_FILE"
            echo "$1=$2" >> "$PROP_FILE"
          }

          set_prop ro.hardware.gralloc gbm
          set_prop ro.hardware.egl mesa
          set_prop gralloc.gbm.device ${intelRenderNode}
          set_prop ro.hardware.vulkan intel

          ${pkgs.gnused}/bin/sed -i '/^$/d' "$PROP_FILE"
        '')
      ];
    };
  };
}
