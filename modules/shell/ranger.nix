{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.ranger = {
    home-manager.sharedModules = [ hm.ranger ];
  };

  flake.modules.homeManager.ranger = { pkgs, ... }: {
    home.packages = [ pkgs.ranger ];
    # `r` opens ranger and cds into the last visited directory on exit.
    programs.bash.initExtra = ''
      unalias r 2>/dev/null
      r() {
        local tmp dir
        tmp=$(mktemp) || return
        command ranger --choosedir="$tmp" "$@"
        if [ -s "$tmp" ]; then
          IFS= read -r dir < "$tmp"
          [ -d "$dir" ] && cd -- "$dir"
        fi
        rm -f -- "$tmp"
      }
    '';
  };
}
