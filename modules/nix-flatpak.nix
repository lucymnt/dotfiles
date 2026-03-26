{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    enable = true;
    packages = [
      {
       appId = "com.alderongames.launcher";
       bundle = "../moodules/programs/bundles/AlderonGamesLauncher.flatpak";
      }
    ];
  };
}


