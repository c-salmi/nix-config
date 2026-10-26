{
  flake.modules.nixos.docker = { config, lib, ... }: {
    virtualisation.docker.enable = true;
    users.users.chadi.extraGroups = [ "docker" ];
    # Generates the CDI spec for `docker run --device nvidia.com/gpu=all`.
    hardware.nvidia-container-toolkit.enable =
      lib.elem "nvidia" config.services.xserver.videoDrivers;
  };
}
