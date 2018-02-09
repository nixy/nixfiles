# Configuration for setting up games and emulators. 
{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Configure retroarch to use cores for DS, PSP, and GBA games
    retroarch = {
      enableDesmume = true;
      enableMGBA = true;
      enablePPSSPP = true;
    };


    # Enable Steam
    allowUnfreePredicate = (pkg:
      builtins.elem (builtins.parseDrvName pkg.name).name [
        "steam"
        "steam-original"
        "steam-runtime"
    ]);
  };

  # Enable hardware support for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = with pkgs; [
    steam
    retroarch
  ];
}
