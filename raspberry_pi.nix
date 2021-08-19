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
  
  networking = {
    interfaces."eth0".mtu = 9000;
    dhcpcd.enable = false;
    domain = "core.gb.oxide.one";
    usePredictableInterfaceNames = false;
    defaultGateway = "10.0.1.1";
    nameservers = ["1.1.1.1"];
  };
}