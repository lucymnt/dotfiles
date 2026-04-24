{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    catppuccin-sddm
    catppuccin-cursors
    hicolor-icon-theme
    papirus-icon-theme
    adwaita-icon-theme
    brightnessctl
    git
    wget
    unzip
    unrar
    lshw
    wev
    steam-run
    polkit_gnome
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.qt6ct
    kdePackages.plasma-integration
    kdePackages.kservice
    kdePackages.kconfig
    kdePackages.kio
    kdePackages.kio-admin
    kdePackages.kde-cli-tools
    kdePackages.kguiaddons
    kdePackages.kio-extras
    kdePackages.gwenview
    glib
    gsettings-desktop-schemas
  ];
  programs.veila.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
  
