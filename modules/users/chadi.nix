{ inputs, ... }:

{
  flake.modules.nixos.chadi = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.chadi = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      packages = with pkgs; [
        tree
      ];
    };

    # Features add their Home Manager halves through home-manager.sharedModules.
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.chadi = {
        home.username = "chadi";
        home.homeDirectory = "/home/chadi";
        home.stateVersion = "26.05";
        programs.git.settings.user = {
          name = "Chadi Salmi";
          email = "salmi.chadi@gmail.com";
        };
      };
    };
  };
}
