# nixos-on-flake
Tricks for NixOS configuration

DISCLAIMER: It's not my live configuration repo, but I put here things which can be useful for others.

## Why flake?
* I can install one package permanently without updating whole system.
  * Maybe its worse for security, but gives more control over system. E.g. on Ubuntu I can `apt install` one thing
  * `apt update` = `nix flake update .`
  * `apt upgrade` = `sudo nixos-rebuild switch --flake ./#dell`
  * `apt install x` = add x to definition in nix file and `sudo nixos-rebuild switch --flake ./#dell`
* If I want to use the same configuration on multiple computers I will have exactly the same packages version on each of them (defined in `flake.lock` file)

## Why home-manager?
* Actually, there is no point of it in my use case.
  * I have a plan to get rid of it and move everything into NixOS configuration.
* It make sense if you want to share home config with other operating systems (macOS, other GNU/Linux distributions)

## What it can?
* Both NixOS and home-manager config in a single flake.
* Install specific packages from unstable channel.
* Various fixes which I found on the way.