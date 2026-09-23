# NixOS dotfiles

This is Chadi's personal NixOS configuration.

## Setup

- Configuration source: `~/nixos-dotfiles`, not `/etc/nixos`.
- Flake output: `nixosConfigurations.nixos-btw`; system hostname: `nixos`.
- Platform: `x86_64-linux`; user: `chadi`; timezone: `Europe/Amsterdam`.
- Inputs: NixOS `nixos-26.05` and Home Manager `release-26.05`, with Home Manager following the same Nixpkgs input.
- Home Manager is a NixOS module: one system rebuild applies both system and user changes.
- `configuration.nix`: system services, hardware integration and system packages.
- `home.nix`: personal packages, shell settings and user configuration.
- `hardware-configuration.nix`: machine-specific generated configuration.

## Desktop and tools

- Niri compositor with the Ly login manager; Alacritty terminal, Fuzzel launcher and Firefox browser.
- Niri configuration lives at `~/.config/niri/config.kdl`; check whether this repo manages it before editing or creating a second copy.
- Pi coding agent is intentionally managed through npm for frequent upstream updates, rather than pinned to Nixpkgs.
- Node.js 24 is managed through Nix. npm's user prefix is `~/.local`, with `~/.local/bin` on PATH through `home.sessionPath`.
- Pi install/update: `npm install -g --prefix "$HOME/.local" --ignore-scripts @earendil-works/pi-coding-agent@latest`.
- Bash customization can live in `config/bash/bashrc`, included with `programs.bash.bashrcExtra = builtins.readFile ./config/bash/bashrc;`. Inspect the current files to confirm wiring.

## Working conventions

- Prefer small, explicit changes. Merge into existing attribute sets and lists rather than duplicating definitions.
- Keep personal packages in `home.packages` and system-wide packages in `environment.systemPackages`.
- Do not edit generated Home Manager files or anything under `/nix/store` directly; do not use `sudo npm install`.
- Preserve `system.stateVersion`, `home.stateVersion`, hardware configuration and unrelated settings unless the task specifically requires changing them.
- New files in a Git-backed flake must be tracked for Nix to see them. Stage only relevant files; do not commit or push unless requested.

## Apply and check

Run from `~/nixos-dotfiles`:

```bash
# Build without activating, when a check is useful:
nixos-rebuild build --flake .#nixos-btw

# Apply system and Home Manager changes:
sudo nixos-rebuild switch --flake .#nixos-btw

# Validate a proposed Niri config before installing it:
niri validate --config path/to/config.kdl
```

Report what changed, what was checked and whether the new configuration was activated. Never claim a build or validation passed without running it.
