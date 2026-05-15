{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
  };
  users.users.lucyst.shell = pkgs.zsh;
}
