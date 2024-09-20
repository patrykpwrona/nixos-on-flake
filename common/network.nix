{ config, pkgs, pkgs-unstable, ... }:
{
  ## Network manager was enabled after installation
  networking.networkmanager.enable = true;
  
  ## DNS Servers
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
 
  ## Custom /etc/hosts file
  networking.extraHosts = ''
  127.0.0.1 youtube.com
  127.0.0.1 www.youtube.com
  127.0.0.1 m.youtube.com
  '';

  ## Firewall
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 51820 ];
    allowedTCPPorts = [ 8443 ];
  };    

  ## Tailscale VPN
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.tailscale.package = pkgs-unstable.tailscale; # newest version
  # tailscale login
  # tailscale up --accept-routes

}