{ config, pkgs, nixpkgs-unstable, ... }:

let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    niri = "niri";
    tmux = "tmux";
  };
in
{
  home.username = "chadi";
  home.homeDirectory = "/home/chadi";
  programs.git = {
    enable = true;
    settings.user = {
      name = "Chadi Salmi";
      email = "salmi.chadi@gmail.com";
    };
  };
  home.stateVersion = "26.05";
  programs.noctalia.enable = true;
  home.packages = with pkgs; [
    gh
    htop
    ranger
    tmux
    tmuxp
    uv
    zenoh
    git-lfs
    gcc
    linuxHeaders
    stdenv.cc.cc.lib
    zlib
    vscode
    unstable.code-cursor
    lm_sensors
  ];
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.sessionVariables = {
    CPATH = "${pkgs.linuxHeaders}/include";
  };
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = createSymlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./config/bash/bashrc;
    shellAliases = {
      btw = "echo I use nixos, btw";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
      gb = "git branch";
      gs = "git status --short";
      gl = "git log --all --decorate --oneline --graph";
      ga = "git add";
      gd = "git diff";
      gdc = "git diff --cached";
      r = ". ranger";
    };
  };
}
