# nixos-on-flake
Tricks for NixOS configuration

DISCLAIMER: It's not my live configuration repo, but I put here things which can be useful for others.

## Why flake?
* I can install one package permanently without updating whole system.
  * Maybe its worse for security, but gives more control over system. E.g. on Ubuntu I can `apt install` one thing without updating all packages.
  * `apt update` = `nix flake update .`
  * `apt upgrade` = `sudo nixos-rebuild switch --flake ./#dell`
  * `apt install x` = add x to definition in nix file and `sudo nixos-rebuild switch --flake ./#dell`
* If I want to use the same configuration on multiple computers I will have exactly the same packages version on each of them (defined in `flake.lock` file)

## Why home-manager?
* Actually, there is no point of it in my use case.
  * I have a plan to get rid of it and move everything into NixOS configuration.
* It make sense if you want to share home config with other operating systems, where home-manager can be installed (macOS, other GNU/Linux distributions).

## What it can?
* Both NixOS and home-manager config in a single flake.
  * [Done here](./flake.nix)
* Install all packages from stable but some from unstable channel.
  * [Declare both stable and unstable as input](./flake.nix#L5-L6)
  * [Pass them to flake](./flake.nix#L13-L24)
  * [Also special arg](./flake.nix#L32)
  * [Read them as a paremeter](./common/packages.nix#L1)
  * [Install from unstable](./common/packages.nix#L60)
* Various fixes which I found on the way.