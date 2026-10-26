{
  flake.modules.nixos.ollama = { pkgs, ... }: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "8192";
        OLLAMA_NO_CLOUD = "1";
      };
    };
  };
}
