{
  flake.modules.nixos.sunshine = { pkgs, ... }: {
    services.sunshine = {
      enable = true;
      # Use unstable for timely Sunshine security updates.
      package = pkgs.unstable.sunshine;
      autoStart = true;
      openFirewall = true;
      # Niri/Wayland needs privileged DRM/KMS screen capture.
      capSysAdmin = true;
      # Keep settings/apps editable in the web UI; encoding is auto-detected.
    };
  };
}
