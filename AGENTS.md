# NixOS dotfiles

This is Chadi's personal NixOS configuration.

## Setup

- Configuration source: `~/nix-config`, not `/etc/nixos`.
- Flake output: `nixosConfigurations.nixos-btw`; system hostname: `nixos`.
- Platform: `x86_64-linux`; user: `chadi`; timezone: `Europe/Amsterdam`.
- Inputs: NixOS `nixos-26.05` and Home Manager `release-26.05`, with Home Manager following the same Nixpkgs input.
- Home Manager is a NixOS module: one system rebuild applies both system and user changes.
- Dendritic layout: `flake.nix` is `flake-parts.lib.mkFlake` over `import-tree ./modules`, so every `.nix` file under `modules/` is a flake-parts module, loaded automatically. Files starting with `_` are skipped.
- Feature files define `flake.modules.nixos.<name>` and/or `flake.modules.homeManager.<name>`; a NixOS feature pulls in its Home Manager half via `home-manager.sharedModules`.
- `modules/hosts/nixos-btw/default.nix`: the host, a list of enabled features; `_hardware-configuration.nix` beside it is the generated hardware config.
- `modules/users/chadi.nix`: the user account and Home Manager setup. `modules/nix.nix` adds the `pkgs.unstable` overlay.

## Desktop and tools

- Niri compositor with the Ly login manager; Alacritty terminal, Fuzzel launcher and Firefox browser.
- Niri configuration lives at `~/.config/niri/config.kdl`, an out-of-store symlink to `modules/desktop/niri/config.kdl` in this repo; tmux config is linked the same way from `modules/shell/tmux/`.
- Pi coding agent is intentionally managed through npm for frequent upstream updates, rather than pinned to Nixpkgs.
- Node.js 24 is managed through Nix. npm's user prefix is `~/.local`, with `~/.local/bin` on PATH through `home.sessionPath`.
- Pi install/update: `npm install -g --prefix "$HOME/.local" --ignore-scripts @earendil-works/pi-coding-agent@latest`.
- Bash customization lives in `modules/shell/bash/bashrc`, included by `modules/shell/bash/default.nix` through `programs.bash.bashrcExtra`.

## Working conventions

- Prefer small, explicit changes. Merge into existing attribute sets and lists rather than duplicating definitions.
- Add functionality as a feature module in the matching `modules/` subdirectory and enable it in the host's list. Keep personal packages in `home.packages` (the Home Manager half) and system-wide packages in `environment.systemPackages`.
- Do not edit generated Home Manager files or anything under `/nix/store` directly; do not use `sudo npm install`.
- Preserve `system.stateVersion`, `home.stateVersion`, hardware configuration and unrelated settings unless the task specifically requires changing them.
- New files in a Git-backed flake must be tracked for Nix to see them. Stage only relevant files; do not commit or push unless requested.

## Apply and check

Run from `~/nix-config`:

```bash
# Build without activating, when a check is useful:
nixos-rebuild build --flake .#nixos-btw

# Apply system and Home Manager changes:
sudo nixos-rebuild switch --flake .#nixos-btw

# Validate a proposed Niri config before installing it:
niri validate --config path/to/config.kdl
```

Report what changed, what was checked and whether the new configuration was activated. Never claim a build or validation passed without running it.
