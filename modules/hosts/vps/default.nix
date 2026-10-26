{ inputs, config, ... }:

{
  flake.nixosConfigurations.vps = inputs.nixpkgs.lib.nixosSystem {
    modules = with config.flake.modules.nixos; [
      inputs.disko.nixosModules.disko
      "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
      ./_disko.nix
      ./_hardware-configuration.nix
      {
        networking.hostName = "vps";
        nixpkgs.hostPlatform = "x86_64-linux";
        system.stateVersion = "26.05";

        boot.loader.grub = {
          efiSupport = true;
          efiInstallAsRemovable = true;
        };

        # Hetzner hands out IPv4 by DHCP but IPv6 only as a static /64.
        networking.useNetworkd = true;
        systemd.network.networks."10-wan" = {
          matchConfig.Name = "en* eth*";
          networkConfig.DHCP = "ipv4";
          # The server's IPv6 /64 from the Hetzner console.
          address = [ "2a01:4f8:c2c:4db9::1/64" ];
          routes = [ { Gateway = "fe80::1"; } ];
        };

        # Lets `nixos-rebuild --target-host chadi@...` copy locally built, unsigned paths.
        nix.settings.trusted-users = [ "@wheel" ];

        nix.gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d";
        };
      }

      nix locale ssh-hardened base-packages
      chadi
      bash ranger cli-tools
      caddy website
    ];
  };
}
