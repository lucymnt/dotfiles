{ config, pkgs, ... }:
{
   qt = {
     enable = true;
     platformTheme.name = "kde";
     style = {
       name = "Darkly";
       package = pkgs.darkly;
     };
   };
   home.packages = with pkgs; [
     darkly
   ];
   xdg.dataFile."color-schemes".source = ../dotfiles/color-schemes;
   xdg.configFile."kdeglobals".text = "
[General]
ColorScheme=CatppuccinMochaMauve
TerminalApplication=foot

[UiSettings]
ColorScheme=CatppuccinMochaMauve

   ";
}
