{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./system/core
      ./system/packages.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "mango-nix";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };
 
#  environment.sessionVariables = {
#    WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:01:00.0-card:/dev/dri/by-path/pci-0000:00:02.0-card";
#    LIBVA_DRIVER_NAME = "nvidia"; 
#    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#  };
#  environment.sessionVariables = {
#    GBM_BACKEND = "nvidia-drm";
#    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    open = false;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    dynamicBoost.enable = false;
    nvidiaSettings = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    #  offload = {
    #    enable = true;
    #    enableOffloadCmd = true;
    #  };
      sync.enable = true;
    };
  };
  services.xserver = {
    videoDrivers = ["nvidia"];
  };
  xdg.portal = {
    enable = true;
    config = {
      wlroots = {
        default = [
          "wlr"
          "kde"
        ];
      };
    };
  };

  security.polkit.enable = true;

  environment.variables = {
    NVD_BACKEND = "direct";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_DRM_NO_ATOMIC = "1";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
  networking.wireless.enable = false;
  networking.networkmanager.enable = false;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
      Network = {
        EnableIPv6 = true;
      };
    };
  };
  #environment.etc."xdg/menus/applications.menu".source = 
  #"${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  users.users.lucyst = {
    isNormalUser = true;
    description = "lucy";
    extraGroups = [  "wheel" ];
    packages = with pkgs; [];
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
