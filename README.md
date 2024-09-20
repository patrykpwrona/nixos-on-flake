# nixos-on-flake
Tricks for NixOS configuration

DISCLAIMER: It's not my live configuration repo, but I put here things which can be useful for others.

## Why flake?
* I can install one package permanently without updating whole system.
  * Maybe its worse for security, but gives more control over system. E.g. on Ubuntu I can `apt install` one thing without updating all packages.
  * `apt update` = `nix flake update .`
  * `apt upgrade` = `sudo nixos-rebuild switch --flake ./#dell`
  * `apt install x` = add x to definition in nix file and `sudo nixos-rebuild switch --flake ./#dell`
* If I want to use the same configuration on multiple computers I will have exactly the same packages version on each of them (defined in `flake.lock` file).
* I have channel declared in files - no need to use `nix-channel` command.

## Why home-manager?
* Actually, there is no point of it in my use case.
  * I have a plan to get rid of it and move everything into NixOS configuration.
* It make sense if you want to share home config with other operating systems, where home-manager can be installed (macOS, other GNU/Linux distributions).
* In home-manager you can have more thins in Nix syntax, so you can probably use variables and other things in more convenient way.

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
* [Bash configuration - aliases, history, functions](./common/bash.nix)
* [Install Steam](./common/gaming.nix)
* [Global git config using home-manager](./common/home.nix#L22-L31)
* [Install VS Code plugins using NixOS configuration](./common/packages.nix#L28-L42)
* [Install VS Code plugins and configure VS Code using home-manager (settings, key bindings)](./common/home.nix#L82-L130)
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
