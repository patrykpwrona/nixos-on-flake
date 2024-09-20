{ config, pkgs, ... }:
{
  ## Create user account 
  users.users.pw = {
    isNormalUser = true;
    description = "pw";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  ## Custom sudo - here without requirement of typing in password
  security.sudo.extraRules = [{ 
    users = [ "pw" ];
      commands = [
        { 
           command = "ALL" ;
           options= [ "NOPASSWD" ]; 
        }
     ];
  }];
}