{ config, pkgs, lib, ... }:

let
  davinci-resolve-custom = import ../pkgs/davinci-resolve { inherit pkgs; };
in
{
  imports = [
    ./desktop/sway.nix
    ./programs/kitty.nix
    ./programs/fuzzel.nix
    ./programs/tmux.nix
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
    vscodium

    # Desktop apps
    vesktop
    figma-linux
    signal-desktop
    davinci-resolve-custom
  ];

  # Basic XDG configuration
  xdg.enable = true;

  # Environment variables
  home.sessionVariables = {
    # Make all Electron apps use Wayland when available
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # Force Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
  };
}
