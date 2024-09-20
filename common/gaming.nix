{ config, pkgs, pkgs-unstable, ... }:
{
  ## Steam
  programs.steam = {
    enable = true; 
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true; 
  };
  programs.gamemode.enable = true;
  ## OpenGL - options for 24.05 channel
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
  ## OpenGL - options for unstable
  #hardware.graphics = {
  #  enable = true;
  #  enable32Bit = true;
  #};

  ## Borderlands GOTY (Game Of The Year Edition) - on Steam
  # Borderlands 1 requires physxcudart_20.dll file in ~/.local/share/Steam/steamapps/common/Borderlands/Binaries/ or ~/.local/share/Steam/steamapps/common/Borderlands/Prerequisites/
  # I downloaded from here https://www.dll-files.com/download/ee21928c80012525513d4d942248ca79/physxcudart_20.dll.html?c=VTh0SFk4cmoxQnRUWXZUWktPeG9lUT09
  # Working on Proton-9.0.1 (steam embeded) - only this version tested - this need to be enabled in Steam app settings
  
}