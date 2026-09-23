{ pkgs, ... }:

{
  # Run prebuilt Linux executables shipped in Python wheels (e.g. the Rerun viewer).
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      systemd
      zlib
      libGL
      vulkan-loader
      libxkbcommon
      wayland
      libx11
    ];
  };
}
