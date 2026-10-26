{ inputs, config, ... }:

{
  flake.nixosConfigurations.nixos-btw = inputs.nixpkgs.lib.nixosSystem {
    modules = with config.flake.modules.nixos; [
      ./_hardware-configuration.nix
      {
        networking.hostName = "nixos";
        system.stateVersion = "26.05";
      }

      nix boot networking locale ssh base-packages
      chadi
      nvidia bluetooth
      niri noctalia fonts firefox apps
      ollama docker sunshine steam
      toolchain node-pi editors python git-tools robotics
      bash tmux ranger cli-tools
    ];
  };
}
