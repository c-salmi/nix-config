{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.robotics = { pkgs, ... }: {
    # USB permissions for RealSense cameras (viewer lives in the dev shell).
    services.udev.packages = [ pkgs.librealsense ];
    # Binary cache for nix-ros-overlay (ROS 2 dev shells).
    nix.settings.substituters = [ "https://ros.cachix.org" ];
    nix.settings.trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
    home-manager.sharedModules = [ hm.robotics ];
  };

  flake.modules.homeManager.robotics = { pkgs, ... }: {
    home.packages = [ pkgs.zenoh ];
  };
}
