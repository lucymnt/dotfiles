{ config, pkgs, ... }:
{
   home.packages = with pkgs; [
     vim
     hypridle
     xdg-utils
     shared-mime-info
     foot
     vlc
     btop
     bat
     cava
     fastfetch
     gapless
     playerctl
     swaybg
     rofi
     rofi-emoji
     wiremix
     bluetui
     impala
     satty
     grim
     slurp
     tree
     vesktop
     wl-clipboard
     kew
     gapless
     obs-studio
     prismlauncher
     stremio-linux-shell
     libreoffice
     lazygit
     picard
     kid3
     eartag
     (import ../pkgs/alderon-games-launcher.nix { inherit pkgs; })
     (import ../pkgs/hayase.nix { inherit pkgs; })
     (import ../pkgs/helium-browser.nix { inherit pkgs; })
   ];
   services.flatpak.packages = [
     "org.vinegarhq.Sober"
     "com.github.tchx84.Flatseal"
     "io.github.astralvixen.geforce-infinity"
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
   
