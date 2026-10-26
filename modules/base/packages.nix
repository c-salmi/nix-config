{
  flake.modules.nixos.base-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
    ];
  };
}
