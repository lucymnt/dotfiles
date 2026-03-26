{ pkgs, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    configFile = ../dotfiles/zsh/catppuccin_mocha.omp.json;  
  }; 
  programs.zsh.enable = true;
}




