{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.nvim = {
    home-manager.sharedModules = [ hm.nvim ];
  };

  flake.modules.homeManager.nvim = { config, pkgs, ... }: {
    # LazyVim manages its plugins itself; Nix only provides Neovim and external tools.
    home.packages = with pkgs; [
      neovim
      tree-sitter
      ripgrep
      fd
      fzf
      lazygit
      unzip # used by Mason to unpack language servers
    ];
    # Out-of-store symlink of the whole directory, so lazy.nvim can write
    # lazy-lock.json and Lua edits apply without a rebuild.
    xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/modules/dev/nvim/config";
  };
}
