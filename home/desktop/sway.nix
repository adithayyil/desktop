{ config, pkgs, lib, ... }:

let
  mod = "Mod4";
  terminal = "kitty";
  menu = "fuzzel";

  colors = {
    base = "#eff1f5";
    text = "#4c4f69";
    lavender = "#7287fd";
    overlay0 = "#9ca0b0";
    rosewater = "#dc8a78";
    peach = "#fe640b";
  };
in
{
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = mod;
      inherit terminal menu;

      bars = [];

      # Displays
      output = {
        # Home monitor
        "DP-4" = {
          mode = "1920x1080@165.003Hz";
          position = "0,-1080";
          bg = "${colors.base} solid_color";
        };
        # School monitor
        "HDMI-A-1" = {
          mode = "2560x1440@59.951Hz";
          position = "0,-1440";
          bg = "${colors.base} solid_color";
        };
        # Laptop display
        "eDP-1" = {
          mode = "1920x1080@60.001Hz";
          position = "0,0";
          bg = "${colors.base} solid_color";
        };
      };

      # Touchpad 
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
        };
      };

      # Window 
      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
      };

      gaps = {
        inner = 10;
        outer = 5;
      };

      # Colors
      colors = {
        focused = {
          border = colors.lavender;
          background = colors.base;
          text = colors.text;
          indicator = colors.lavender;
          childBorder = colors.lavender;
        };
        focusedInactive = {
          border = colors.overlay0;
          background = colors.base;
          text = colors.text;
          indicator = colors.rosewater;
          childBorder = colors.overlay0;
        };
        unfocused = {
          border = colors.overlay0;
          background = colors.base;
          text = colors.text;
          indicator = colors.rosewater;
          childBorder = colors.overlay0;
        };
        urgent = {
          border = colors.peach;
          background = colors.base;
          text = colors.peach;
          indicator = colors.overlay0;
          childBorder = colors.peach;
        };
      };

      # Keybindings
      keybindings = {
        # Basic
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+w" = "kill";
        "${mod}+space" = "exec ${menu}";
        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+e" = "exec swaymsg exit";

        # Focus (vim-style)
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move windows (vim-style)
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Move workspace between monitors
        "${mod}+Shift+Up" = "move workspace to output up";
        "${mod}+Shift+Down" = "move workspace to output down";

        # Switch to workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        # Move container to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # Layout
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+space" = "floating toggle";

        # Media keys
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

        # Screenshots
        "${mod}+s" = "exec hyprshot -m region -o ~/img/ss/";
        "${mod}+Shift+s" = "exec hyprshot -m region --clipboard-only";

        # Audio output switcher
        "${mod}+Shift+a" = "exec ${config.home.homeDirectory}/.config/sway/audio_switcher.sh";
      };

      # Startup applications
      startup = [
        { command = "waybar"; }
        { command = "swaymsg 'workspace number 1; exec ${terminal}'"; }
        { command = "swaymsg 'workspace number 2; exec codium'"; }
        { command = "swaymsg 'workspace number 3; exec firefox'"; }
        { command = "swaymsg 'workspace number 4; exec vesktop'"; }
      ];
    };

    extraConfig = ''
      # Include system-level sway configs
      include /etc/sway/config.d/*
    '';
  };

  # Audio switcher script
  home.file.".config/sway/audio_switcher.sh" = {
    source = ./scripts/audio_switcher.sh;
    executable = true;
  };
}
