{ config, lib, pkgs, ... }:

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

    # Desktop environment
    ./modules/desktop/sway.nix
    ./modules/desktop/greetd.nix

    # Programs
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/steam.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    kitty
    vesktop
    claude-code
    uv
    vscodium
    btop
  ];

  # NixOS release version (DO NOT CHANGE)
  system.stateVersion = "25.05";
}
