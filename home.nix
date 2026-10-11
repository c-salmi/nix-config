{ config, pkgs, ... }:

let
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
    htop
    ranger
    tmux
    uv
    python311
    lm_sensors
  ];
  home.sessionPath = [ "$HOME/.local/bin" ];
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
