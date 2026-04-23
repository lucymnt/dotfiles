{ config, ... }:
{
   home.file = {
     ".config/mango/" = {
       source = ../dotfiles/mango;
       recursive = true;
     };
     ".config/foot/" = {
       source = ../dotfiles/foot;
       recursive = true;
     };
     ".config/zsh/" = {
       source = ../dotfiles/zsh;
       recursive = true;
     };
     ".config/waybar/" = {
       source = ../dotfiles/waybar;
       recursive = true;
     }; 
     ".config/hypr/" = {
       source = ../dotfiles/hypr;
       recursive = true;
     };
     ".config/rofi/" = {
       source = ../dotfiles/rofi;
       recursive = true;
     };
     ".config/swaync/" = {
       source = ../dotfiles/swaync;
       recursive = true;
     };
   }; 
   programs.zsh.dotDir = config.home.homeDirectory;
}

 
