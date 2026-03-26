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
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, mango, dolphin-overlay, ... }@inputs: {
    nixosConfigurations.mango-nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Passes all inputs to sub-modules (configuration.nix, home.nix, etc.)
      specialArgs = { inherit inputs; }; 
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.lucyst = import ./home.nix;
            # Pass inputs to home-manager modules as well
            extraSpecialArgs = { inherit inputs; };
          };
        }
          mango.nixosModules.mango
        {
          programs.mango.enable = true;
        }
        {
          nixpkgs.overlays = [ dolphin-overlay.overlays.default ];
        }
      ];
    };
  };
}

