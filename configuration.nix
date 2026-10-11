{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/nix-ld.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  # USB permissions for RealSense cameras (viewer lives in the dev shell).
  services.udev.packages = [ pkgs.librealsense ];

  time.timeZone = "Europe/Amsterdam";

  programs.niri.enable = true;
  services.displayManager.ly.enable = true;

  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
  hardware.bluetooth.enable = true;

  virtualisation.docker.enable = true;
  # Generates the CDI spec for `docker run --device nvidia.com/gpu=all`.
  hardware.nvidia-container-toolkit.enable = true;

  users.users.chadi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
    fuzzel
    xwayland-satellite
    nodejs_24
    bluez
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}

