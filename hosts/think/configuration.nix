{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Hardware configuration
    # cp hardware-configuration.nix hardware.nix
    # ./hardware.nix

    # Common modules
    ../../common/boot.nix
    ../../common/networking.nix
    ../../common/users.nix
    ../../common/fonts.nix
    ../../common/nix.nix

    # Desktop profile
    ../../profiles/desktop

    # Programs
    ../../programs/firefox.nix
    ../../programs/steam.nix
  ];

  # Desktop-specific: Enable NetworkManager
  networking.networkmanager.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
  ];

  # [!!DO NOT CHANGE!!] NixOS release version [!!DO NOT CHANGE!!]
  system.stateVersion = "25.05";
}
