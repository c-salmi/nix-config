{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.robotics = { pkgs, ... }: {
    # USB permissions for RealSense cameras (viewer lives in the dev shell).
    services.udev.packages = [ pkgs.librealsense ];
    home-manager.sharedModules = [ hm.robotics ];
  };

  flake.modules.homeManager.robotics = { pkgs, ... }: {
    home.packages = [ pkgs.zenoh ];
  };
}
