{ config, lib, ... }:
{
   home.file = {
     ".local/share/PrismLauncher" = {
       source = config.lib.file.mkOutOfStoreSymlink "/mnt/neon/home/lucymn/.local/share/PrismLauncher";
     };
   }; 
}

