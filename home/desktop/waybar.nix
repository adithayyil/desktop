{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;

        modules-left = [
          "custom/nixos"
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "pulseaudio"
          "battery"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            default = "●";
          };
        };

        "sway/mode" = {
          format = "<span style=\"italic\"> {}</span>";
        };

        "custom/nixos" = {
          format = "󱄅";
          tooltip = false;
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ccd0da'><b>{}</b></span>";
              days = "<span color='#ccd0da'><b>{}</b></span>";
              weeks = "<span color='#9ca0b0'><b>W{}</b></span>";
              weekdays = "<span color='#dc8a78'><b>{}</b></span>";
              today = "<span color='#7287fd'><b><u>{}</u></b></span>";
            };
          };
          interval = 60;
        };

        tray = {
          icon-size = 15;
          spacing = 8;
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "kitty -e bluetoothctl";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-icons = {
            default = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
          };
          states = {
            warning = 30;
            critical = 15;
          };
          interval = 1;
          tooltip-format = "{timeTo}\n{power}W";
        };

        network = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n󰇚 {bandwidthDownBytes}  󰕒 {bandwidthUpBytes}";
          tooltip-format-ethernet = "{ifname}\n󰩟 {ipaddr}\n󰓅 {gwaddr}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "kitty -e nmtui";
          interval = 5;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 {volume}%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          tooltip-format = "{desc}\n{volume}%";
          max-volume = 100;
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: Inter, "Symbols Nerd Font", sans-serif;
          font-size: 13px;
          font-weight: 500;
          min-height: 0;
      }
      window#waybar {
          background: #eff1f5;
          color: #4c4f69;
          border-bottom: 2px solid #7287fd;
      }
      /* Workspaces */
      #workspaces {
          margin: 0 4px;
      }
      #workspaces button {
          padding: 0 8px;
          background: transparent;
          color: #4c4f69;
          transition: all 0.2s ease;
          font-size: 14px;
      }
      #workspaces button.focused,
      #workspaces button.active {
          background: #7287fd;
          color: #eff1f5;
          font-weight: 600;
      }
      #workspaces button.urgent {
          background: #d20f39;
          color: #eff1f5;
      }
      #workspaces button:hover {
          background: #ccd0da;
          color: #4c4f69;
      }
      /* Custom NixOS logo */
      #custom-nixos {
          padding: 0 6px 0 12px;
          color: #7287fd;
          font-size: 16px;
          font-weight: 700;
      }
      /* Mode indicator */
      #mode {
          background: #d20f39;
          color: #eff1f5;
          padding: 0 12px;
          margin: 0 4px;
      }
      /* Center module */
      #clock {
          padding: 0 16px;
          font-weight: 600;
          color: #4c4f69;
      }
      /* Right modules - all same color, minimal */
      #tray,
      #bluetooth,
      #pulseaudio,
      #network,
      #battery {
          padding: 0 6px;
          color: #4c4f69;
      }
      /* Bluetooth states */
      #bluetooth.disabled {
          color: #6c6f85;
      }
      #bluetooth.connected {
          color: #4c4f69;
      }
      /* Network disconnected state */
      #network.disconnected {
          color: #6c6f85;
      }
      /* Audio muted state */
      #pulseaudio.muted {
          color: #6c6f85;
      }
      /* Battery states */
      #battery.warning {
          color: #df8e1d;
      }
      #battery.critical {
          color: #d20f39;
          animation: blink 1s linear infinite;
      }
      @keyframes blink {
          50% {
              opacity: 0.5;
          }
      }
      /* System tray */
      #tray > .passive {
          -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }
    '';
  };
}
