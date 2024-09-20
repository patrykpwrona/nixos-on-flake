{ config, pkgs, ... }:
{
  ## Hostname
  networking.hostName = "thinkpad";

  ## Version of first install, generated by installer, no need to touch ever
  system.stateVersion = "24.05";
}