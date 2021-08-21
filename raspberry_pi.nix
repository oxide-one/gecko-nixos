{ config, pkgs, lib, ... }:
{
  nixpkgs = rec {
        crossSystem = (import <nixpkgs> {}).pkgsCross.aarch64-multiplatform.stdenv.targetPlatform;
        localSystem = crossSystem;
  };

  imports = [
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}//raspberry-pi/4"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  
  environment.systemPackages = with pkgs; [
      raspberrypifw
      raspberrypi-eeprom
      libraspberrypi
  ];

  hardware.raspberry-pi."4".poe-hat.enable = true;
  
  boot.loader.raspberryPi.firmwareConfig = [
    "hdmi_force_hotplug=1"
    "hdmi_drive=2"
  ];
}