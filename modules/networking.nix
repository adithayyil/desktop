{ config, lib, pkgs, ... }:

{
  networking.hostName = "think";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";
}
