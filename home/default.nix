{ config, pkgs, lib, ... }:

{
  imports = [
    ./desktop/sway.nix
    ./programs/kitty.nix
    ./programs/fuzzel.nix
    ./programs/tmux.nix
    ./programs/vscodium.nix
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
    # CLI 
    neovim
    wget
    btop
    just

    # Dev
    claude-code
    github-copilot-cli
    uv

    # Desktop apps
    vesktop
    figma-linux
    signal-desktop
    davinci-resolve
  ];

  # Basic XDG configuration
  xdg.enable = true;
}
