{ config, ... }:
{
  xdg = {
     enable = true;
     mimeApps = {
       enable = true;
       defaultApplications = {
         "text/plain" = [ "vim.desktop" ];
         "video/mp4"       = "org.kde.haruna.desktop";
         "video/x-matroska" = "org.kde.haruna.desktop";
         "video/mpeg"      = "org.kde.haruna.desktop";
         "video/ogg"       = "org.kde.haruna.desktop";
         "video/quicktime" = "org.kde.haruna.desktop";
         "video/vnd.avi"   = "org.kde.haruna.desktop";
         "video/mp2t"      = "org.kde.haruna.desktop";
         "video/webm"      = "org.kde.haruna.desktop";
         "video/x-ms-wmv"  = "org.kde.haruna.desktop";
         "image/jpeg"      = "org.kde.gwenview.desktop";
         "image/png"       = "org.kde.gwenview.desktop";
         "image/gif"       = "org.kde.gwenview.desktop";
         "image/webp"      = "org.kde.gwenview.desktop";
       };
     };
    };
}
