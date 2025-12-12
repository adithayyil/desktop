{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Hardware (machine-specific, stays in /etc/nixos)
    /etc/nixos/hardware-configuration.nix

    # System modules
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/fonts.nix
    ./modules/services.nix
    ./modules/power.nix
    ./modules/graphics.nix
    ./modules/fingerprint.nix

    # Desktop environment
    ./modules/desktop/sway.nix
    ./modules/desktop/greetd.nix

    # Programs
    ./programs/firefox.nix
    ./programs/steam.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Helper utility for Nix/NixOS commands
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/adi/nix";
  };

  # System packages
  environment.systemPackages = with pkgs; [
  ];

  # [!!DO NOT CHANGE!!] NixOS release version [!!DO NOT CHANGE!!]
  system.stateVersion = "25.05";
}
