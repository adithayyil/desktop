{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # Catppuccin Latte colors
      color = "eff1f5"; # Base background

      # Clock
      clock = true;
      timestr = "%H:%M";
      datestr = "%a, %d %b";

      # Indicator ring colors
      ring-color = "9ca0b0"; # Overlay0 (inactive)
      ring-ver-color = "7287fd"; # Lavender (verifying)
      ring-wrong-color = "d20f39"; # Red (wrong password)
      ring-clear-color = "fe640b"; # Peach (clearing)

      # Inside indicator colors
      inside-color = "eff1f5"; # Base
      inside-ver-color = "7287fd"; # Lavender
      inside-wrong-color = "d20f39"; # Red
      inside-clear-color = "eff1f5"; # Base

      # Line between ring and inside
      line-color = "eff1f5"; # Base
      line-ver-color = "eff1f5"; # Base
      line-wrong-color = "eff1f5"; # Base
      line-clear-color = "eff1f5"; # Base

      # Text colors
      text-color = "4c4f69"; # Text
      text-ver-color = "4c4f69"; # Text
      text-wrong-color = "4c4f69"; # Text
      text-clear-color = "4c4f69"; # Text

      # Key press highlight
      key-hl-color = "7287fd"; # Lavender
      bs-hl-color = "d20f39"; # Red (backspace)

      # Separator
      separator-color = "9ca0b0"; # Overlay0

      # Layout
      indicator-radius = 100;
      indicator-thickness = 10;

      # Behavior
      show-failed-attempts = true;
      indicator-idle-visible = true;

      # Font
      font = "Inter";
      font-size = 24;
    };
  };
}
