{ config, pkgs, ... }:
{
   home.packages = with pkgs; [
     xdg-utils
     shared-mime-info
   ];
   xdg = {
     enable = true;
     mimeApps = {
       enable = true;
       defaultApplications = {
         "text/plain" = [ "vim.desktop" ];
       };
     };
    };
}
   
