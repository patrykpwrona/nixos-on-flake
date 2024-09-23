# nixos-on-flake
Tricks for NixOS configuration

DISCLAIMER: It's not my live configuration repo, but I put here things which can be useful for others.

## Why flake?
* I can install one package permanently without updating whole system.
  * Maybe its worse for security, but gives more control over system. E.g. on Ubuntu I can `apt install` one thing without updating all packages.
  * `apt update` = `nix flake update .`
  * `apt upgrade` = `sudo nixos-rebuild switch --flake ./#dell`
  * `apt install x` = add x to definition in nix file and `sudo nixos-rebuild switch --flake ./#dell`
  * temporary `apt install x` = `nix-shell -p x`
* If I want to use the same configuration on multiple computers I will have exactly the same packages version on each of them (defined in `flake.lock` file).
* I have channel declared in files - no need to use `nix-channel` command.

## Why home-manager?
* Actually, there is no point of it in my use case.
  * I have a plan to get rid of it and move everything into NixOS configuration.
* It make sense if you want to share home config with other operating systems, where home-manager can be installed (macOS, other GNU/Linux distributions).
* In home-manager you can have more things in Nix syntax, so you can probably use variables and other stuff in more convenient way.

## What it can?
* [Both NixOS and home-manager config in a single flake](./flake.nix)
* Configuration split in common part and specific for each computer
* Install all packages from stable but some from unstable channel
  * [Declare both stable and unstable as inputs](./flake.nix#L5-L6)
  * [Pass them to flake](./flake.nix#L13-L24)
  * [Also special arg](./flake.nix#L32)
  * [Read them as a parameter](./common/packages.nix#L1)
  * [Install from unstable](./common/packages.nix#L60)
* [Sudo configuration](./common/users.nix#L11-L19)
* [Bash configuration - aliases, history size, functions](./common/bash.nix)
* [Edit /etc/hosts file](./common/network.nix#L12-L17)
* [Open ports in firewall](./common/network.nix#L19-L24)
* [Install python modules](./common/packages.nix#L24-L26)
* [Install Steam](./common/gaming.nix)
* [Global git config using home-manager](./common/home.nix#L22-L31)
* [Install VS Code plugins using NixOS configuration](./common/packages.nix#L28-L42)
* [Install VS Code plugins and configure VS Code using home-manager (settings, key bindings)](./common/home.nix#L82-L130)
* [Do not install all GNOME default junk apps](./common/packages.nix#L4)
* [Install Tailscale VPN with accept routes option](./common/network.nix#L26-L31)
* [FIX: Your GStreamer installation is missing a plug-in.](./common/packages.nix#L114-L122)
* [Wezterm terminal configuration: keyboard shortcuts, auto switch light/dark theme](./common/home.nix#L33-L80)
* Various fixes and tricks which I found on the way

## Installation manual
* Install NixOS using live usb installer (I used graphical installer)
* Reboot
* Edit files from this repo
  * host names
  * user name
  * all other things you need to change
* Copy generated `/etc/nixos/hardware-configuration.nix` into `nixos-on-flake/specific/$HOST_NAME/hardware-configuration.nix`
* Do things from `Update system` section below

## Usage manual
### Update system
```bash
cd nixos-on-flake/
nix flake update .
sudo nixos-rebuild switch --flake ./#dell
home-manager switch --flake ./#pw
```
### Rollback system state
Rollback nix packages state (not user data)
* While booting system - select previous generation from grub
* While system is running - using the fact that configuration is in version control
```bash
cd nixos-on-flake/
git checkout $COMMIT_THAT_WORKED
sudo nixos-rebuild switch --flake ./#dell
```
