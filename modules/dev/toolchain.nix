{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.toolchain = {
    # Provide the compatibility loader; project dev shells supply extra libraries.
    programs.nix-ld.enable = true;
    home-manager.sharedModules = [ hm.toolchain ];
  };

  flake.modules.homeManager.toolchain = { pkgs, ... }: {
    home.packages = with pkgs; [
      gcc
      linuxHeaders
      stdenv.cc.cc.lib
      zlib
    ];
    home.sessionVariables = {
      CPATH = "${pkgs.linuxHeaders}/include";
    };
  };
}
