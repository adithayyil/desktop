{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware.nix

    ../../common/boot.nix
    ../../common/networking.nix
    ../../common/users.nix
    ../../common/fonts.nix
    ../../common/nix.nix

    ../../profiles/server
  ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    htop
    ncdu
  ];

  nix.settings.trusted-users = [
    "adi"
    "root"
  ];

  # DO NOT CHANGE
  system.stateVersion = "25.05";
}
