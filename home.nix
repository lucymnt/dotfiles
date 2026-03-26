{ config, pkgs, inputs, ... }:
{
   home.username = "lucyst";
   home.homeDirectory = "/home/lucyst";
   home.stateVersion = "25.11";
  
   # fix cursor for mango on my shi
   home.pointerCursor= {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
   };

   imports = [
     ./modules
     inputs.spicetify-nix.homeManagerModules.spicetify
   ];
}
