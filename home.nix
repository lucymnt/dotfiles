{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  home.username = "lucyst";
  home.homeDirectory = "/home/lucyst";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 24;
  };
  services.flatpak.enable = true;
}
