{ config, pkgs, ... }:
{
  ## Create user account 
  users.users.pw = {
    isNormalUser = true;
    description = "pw";
    extraGroups = [ "networkmanager" "wheel" ];
    ## Initial password - this will be set only if user did not exist earlier
    ## after first login change it with `passwd` 
    initialPassword = "initpass123";

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