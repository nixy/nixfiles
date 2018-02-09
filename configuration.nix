# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./kde.nix
      ./nixops.nix
      ./games.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.grub.splashImage = null; 
  networking = {
    hosts = {
      "192.168.56.101" = [ "irc.nixops" ];
    };
    hostName = "dodecahedron";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Goha-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";


  nixpkgs.config = {
    packageOverrides = pkgs: let self = pkgs; in with self; rec {
      passCLI = pkgs.pass.override { gnupg = gnupgCLI; };
      gnupgCLI = pkgs.gnupg.override { guiSupport = false; };
      gnupg1compatCLI = pkgs.gnupg1compat.override { gnupg = gnupgCLI; };
      pythonInteractive = pkgs.python.override { readline = pkgs.readline70; }; 
      python3Interactive = pkgs.python3.override { readline = pkgs.readline70; }; 
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim

    pythonInteractive
    python3Interactive
    passCLI
    gnupgCLI
    gnupg1compatCLI
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.andrew = {
    extraGroups = [ "wheel" "vboxusers" ];
    isNormalUser = true;
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
