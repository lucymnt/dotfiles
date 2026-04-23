{
  description = "lucy's flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    dolphin-overlay = {
      url = "github:rumboon/dolphin-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, mango, dolphin-overlay, nix-flatpak, catppuccin, ... }@inputs: {
    nixosConfigurations.mango-nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        mango.nixosModules.mango
        home-manager.nixosModules.home-manager
        catppuccin.nixosModules.catppuccin
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.lucyst = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
            extraSpecialArgs = { inherit inputs; };
            sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
            ];
          };
          programs.mango.enable = true;
          nixpkgs.overlays = [ 
            dolphin-overlay.overlays.default
            (import ./pkgs/spotify.nix) 
          ];
        }
      ];
    };
  };
}
