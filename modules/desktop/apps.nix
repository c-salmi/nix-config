{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.apps = {
    # Trash, USB/phone mounting and network locations in the file manager.
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    home-manager.sharedModules = [ hm.apps ];
  };

  flake.modules.homeManager.apps = { pkgs, ... }: {
    home.packages = with pkgs; [
      obsidian
      nautilus # file manager
      vlc # video player
      libreoffice # office suite: opens .xlsx/.xlsm/.docx/.pptx
      libreoffice # office suite: opens .xlsx/.xlsm/.docx/.pptx
      visidata # terminal viewer for spreadsheets/CSV (vd file.xlsm)
    ];
  };
}
