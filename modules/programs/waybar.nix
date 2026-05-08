{ pkgs, inputs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "mango-session.target";
    };
  };
}
  
