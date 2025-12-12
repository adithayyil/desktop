{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Deep sleep for better battery life
  boot.kernelParams = [ "mem_sleep_default=deep" ];
}
