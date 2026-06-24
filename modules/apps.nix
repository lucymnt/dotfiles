{ config, pkgs, ... }:
{
   home.packages = with pkgs; [
     vim
     hypridle
     xdg-utils
     shared-mime-info
     foot
     btop
     bat
     cava
     fastfetch
     gapless
     playerctl
     swaybg
     rofi
     rofimoji
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
     suwayomi-server
     libreoffice-qt
     lazygit
     picard
     kid3
     eartag
     wayfreeze
     darkly
     faugus-launcher
     haruna
     eden
     ryubing
     kdePackages.kdenlive
     kdePackages.kate
     ffmpeg
     yt-dlp
     ncdu
     protonup-qt
     pcsx2
     qbittorrent
     (import ../pkgs/alderon-games-launcher.nix { inherit pkgs; })
     (import ../pkgs/hayase.nix { inherit pkgs; })
     (import ../pkgs/helium-browser.nix { inherit pkgs; })
   ];
   programs.lazyvim.enable = true;
   services.flatpak = {
     packages = [
       "org.vinegarhq.Sober"
       "com.github.tchx84.Flatseal"
       "com.stremio.Stremio"
       "io.github.astralvixen.geforce-infinity"
     ];
     update.onActivation = true;
   };
}
   
