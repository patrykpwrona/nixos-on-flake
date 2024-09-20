{ config, pkgs, pkgs-unstable, ... }:
{
  ## Various hardware and system settings, mostly genereated by nixos-installer

  ## Basic Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  ## Locales, keymaps
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };
  services.xserver = {
    xkb.layout = "pl";
    xkb.variant = "";
  };
  console.keyMap = "pl2";

  ## Desktop Environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;  

  ## Audio
  sound.enable = true; # option needed in 24.05, in unstable delete this line
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ## Touchpad
  services.libinput.enable = true;
  # Tap to click need to be manually enabled in GNOME Settings:
  # Settings -> Mouse & Touchpad -> Touchpad (card) -> Tap to Click

  ## Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ## NTFS mounting support
  boot.supportedFilesystems = [ "ntfs" ];

  ## Suspend then hibernate
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10m
  '';

  ## Fstrim - for SSD
  services.fstrim.enable = true;
  # check if your SSD can:
  # lsblk --discard
  # DISC-GRAN and DISC-MAX should be non-zeros
}