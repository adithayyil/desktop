{ config, pkgs, lib, ... }:

{
  imports = [
    ./desktop/sway.nix
    ./programs/kitty.nix
    ./programs/fuzzel.nix
  ];

  # Home Manager settings
  home.username = "adi";
  home.homeDirectory = "/home/adi";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Home Manager version (should match system.stateVersion)
  home.stateVersion = "25.05";

  # User packages that don't need special configuration
  home.packages = with pkgs; [
    # Add any user-specific packages here
  ];

  # Basic XDG configuration
  xdg.enable = true;
}
