# Configuration for systems running an X server and KDE. 
{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.synaptics = {
    enable = true;
    fingersMap = [ 1 3 2 ];
  };
  #boot.extraTTYs = [ "tty7" "tty8" "tty9" "tty10" "tty11" "tty12" ];

  # Enable pulseaudio
  hardware.pulseaudio.enable = true;

  # Enable the SDDM Display Manager
  services.xserver.displayManager.sddm.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable redshift as a service
  services.redshift = {
    enable = true;
    provider = "geoclue2";
  };
  
  # List of fonts to install
  fonts.fonts = with pkgs; [
    fira
    fira-mono
  ];

  # Open ports for KDE connect
  networking = {
    firewall = {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedTCPPorts = [ 139 445 ];
      allowedUDPPorts = [ 137 138 ];
    };
  };

  environment.systemPackages = with pkgs; [
    firefox-esr
    tor-browser-bundle-bin

    libreoffice
    okular

    amarok

    gimp

    gwenview

    kdeconnect

    arc-theme
    #arc-kde-theme
    papirus-icon-theme
  ];
}
