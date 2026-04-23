{ config, lib, ... }:
{
   home.file = {
     ".config/Epic/PathOfTitans" = {
       source = config.lib.file.mkOutOfStoreSymlink "/mnt/neon/home/lucymn/.config/Epic/PathOfTitans";
     };
   }; 
}

