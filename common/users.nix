{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.adi = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
    ];
  };
}
