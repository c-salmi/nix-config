{
  flake.modules.nixos.bluetooth = { pkgs, ... }: {
    hardware.bluetooth.enable = true;
    environment.systemPackages = [ pkgs.bluez ];
  };
}
