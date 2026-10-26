{ inputs, ... }:

{
  # Provides flake.modules.<class>.<name> (nixos, homeManager).
  imports = [ inputs.flake-parts.flakeModules.modules ];
  systems = [ "x86_64-linux" ];
}
