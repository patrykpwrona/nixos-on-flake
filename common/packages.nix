{ config, pkgs, pkgs-unstable, lib, ... }:
{
  ## Do not install default gnome apps
  services.gnome.core-utilities.enable = false;

  ## Packages installed as user
  users.users.pw.packages = with pkgs; [
    ### GNOME apps
    # On unstable channel delete 'gnome.' prefix
    gnome.gnome-terminal # another terminal app as a backup
    gnome.gnome-keyring # for ssh
    gnome.gnome-tweaks # for setting Caps Lock as additional Ctrl (Tweaks -> Keyboard -> Additional layout Options -> Caps Lock behavior)
    gnome.nautilus # file manager
    gnome.eog # image viewer

    ### GNOME extensions
    # To enable gnome extensions: log out and login, open "Extension" app and enable
    gnomeExtensions.appindicator # needed for tray icons to work (e.g for nextcloud)     
    gnomeExtensions.tophat # system usage status widget
    libgtop # for tophat
    gnomeExtensions.vitals # another system usage status widget
    gnomeExtensions.hibernate-status-button # hibernate button

    ### Python modules and apps
    (python311.withPackages(py-packages: with py-packages; [ pyftpdlib ]))
    # python3 -m pyftpdlib

    ### Vscode with extensions - moved to home-manager now, but this is working also
    #(vscode-with-extensions.override {
    #  vscodeExtensions = with vscode-extensions; [
    #    pkief.material-icon-theme        
    #    eamodio.gitlens
    #    bbenoist.nix
    #  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #    {
    #      name = "git-last-commit-message";
    #      publisher = "JanBn";
    #      version = "1.9.0";
    #      sha256 = "atINTAGN0RVYMiiz9LZyPt1YU1IIdlqCjptQo/SpoPM="; # set to anything, first rebuild fail tell you the correct one
    #    }
    #  ];
    #})

    ### Other apps
    papers # pdf viewer
    brave # browser with good adblock
    keepassxc # password manager
    nextcloud-client # nextcloud
    bc # console calculator
    onlyoffice-bin # office
    gnome-frog # screenshot OCR - works but not so good - need to manually open screenshot from files     
    blanket # ambient sounds to focus
    gnome-podcasts # podcasts
    vlc # media player
    alass # subtitle synchronization - alass-cli (I cannot get ffsubsync to work)
    ffmpeg_7 # for alass
    gramps # family tree
    graphviz # for dot for gramps
    
    pkgs-unstable.immich-cli # immich cli - version from stable is very old, and not working         

    ansible
    ansible-lint # for vscode ansible extension

  ];

  ## Packages installed as root (system-wide)
  environment.systemPackages = with pkgs; [
    home-manager
    tree
    vim
    wget
    rsync
    git
    killall
    file
    du-dust # dust - du alternative
    ripgrep # rg - grep alternative
    fd # find alternative
    tldr # short version of man
    unzip
    jq # JSON parser
    fping # ping whole subnet
    htop
    dig
    pwgen
    lm_sensors # commands: sensors, sensors-detect
    smartmontools # read SMART from disks
    ethtool
    nvme-cli # nvme
    gptfdisk # gdisk
    dosfstools # fsck.vfat
    parted # partprobe
    fatrace # show processes which do something on disk
  ];

  ## Programs managed by NixOS
  programs.mtr.enable = true; # mtr
  programs.ssh.startAgent = true; # remember passwords for encrypted ssh private keys

  ## Flatpak
  # flatpak install net.xmind.XMindG # mind map tool
  services.flatpak.enable = true;

  ## Packages added to Gnome session search path
  ### Fixes for various packages
  services.xserver.desktopManager.gnome.sessionPath = [
    pkgs.libgtop # for tophat
    pkgs.goocanvas3 # for gramps
    pkgs.goocanvas2 # for gramps
    pkgs.gobject-introspection # for gramps
  ];
  
  ## Fix for:
  ### Image file properties not showing in file explorer
  ### Your GStreamer installation is missing a plug-in.
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
  gst-plugins-good
  gst-plugins-bad
  gst-plugins-ugly
  gst-libav
  ]);
}