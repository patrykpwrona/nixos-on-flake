{ config, pkgs, pkgs-unstable, ... }:
{
  ## Bash configuration  
  programs.bash = {
    ## Bash aliases available for all users
    shellAliases = {
      ll = "ls -alh";
      rgh = "rg --follow --hidden";
      fdh = "fd --hidden";
    };
    ## Bash configuation - history, defining functions etc. 
    shellInit = ''
      HISTTIMEFORMAT="%d/%m/%y %T "
      HISTSIZE=500000
      HISTFILESIZE=500000

      cdtmp() {
        mkdir "/tmp/$1"; cd "/tmp/$1"
      }
    '';
  };    
}