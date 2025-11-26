{ config, lib, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      brightnessctl
      wl-clipboard
      hyprshot
      swaylock-effects
      swayidle
      waybar
      fuzzel
      pulseaudio
    ];
  };

  # XDG Desktop Portal for screen sharing and file pickers
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
