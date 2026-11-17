{ inputs, config, ... }:

{
  flake.nixosConfigurations.nixos-btw = inputs.nixpkgs.lib.nixosSystem {
    modules = with config.flake.modules.nixos; [
      ./_hardware-configuration.nix
      {
        networking.hostName = "nixos";
        networking.interfaces.enp5s0.wakeOnLan.enable = true;
        system.stateVersion = "26.05";
      }

      nix systemd-boot networkmanager locale ssh base-packages
      chadi
      nvidia bluetooth
      niri noctalia fonts firefox apps recording
      ollama docker sunshine steam
      toolchain node-pi editors nvim python git-tools robotics
      bash tmux ranger cli-tools
    ];
  };
}
