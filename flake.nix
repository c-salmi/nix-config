{
  description = "NixOS Workstation";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia.url = "github:noctalia-dev/noctalia";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, noctalia, ... }: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit nixpkgs-unstable; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit nixpkgs-unstable; };
            sharedModules = [ noctalia.homeModules.default ];
            users.chadi = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
