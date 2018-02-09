# Configuration for systems designed to virtualize other NixOS systems.
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixops
    vagrant
  ];

  virtualisation = {
    virtualbox = {
      host = {
        # Automatically enable vboxnet0 networking
        addNetworkInterface = true;
        enable = true;
        enableHardening = true;
        # Allow GUI virtual machines
        headless = false;
      };
    };
  };
}
