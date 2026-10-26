{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.git-tools = {
    home-manager.sharedModules = [ hm.git-tools ];
  };

  flake.modules.homeManager.git-tools = { pkgs, ... }: {
    programs.git.enable = true;
    home.packages = with pkgs; [
      gh
      git-lfs
    ];
    programs.bash.shellAliases = {
      gb = "git branch";
      gs = "git status --short";
      gl = "git log --all --decorate --oneline --graph";
      ga = "git add";
      gd = "git diff";
      gdc = "git diff --cached";
    };
  };
}
