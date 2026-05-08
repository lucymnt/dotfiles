{ pkgs, inputs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "mango-session.target" ];
    };
  };
}
  
