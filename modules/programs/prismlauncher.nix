{ config, lib, ... }:
{
   home.file = {
     ".local/share/PrismLauncher/instances" = {
       source = config.lib.file.mkOutOfStoreSymlink "/mnt/neon/home/lucymn/.local/share/PrismLauncher/instances";
     };
     ".local/share/PrismLauncher/icons" = {
       source = config.lib.file.mkOutOfStoreSymlink "/mnt/neon/home/lucymn/.local/share/PrismLauncher/icons";
     };
     ".local/share/PrismLauncher/assets" = {
       source = config.lib.file.mkOutOfStoreSymlink "/mnt/neon/home/lucymn/.local/share/PrismLauncher/assets";
     };
   }; 
}
