{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.swayidle = {
    enable = true;
    events = {
      # Lock before sleep
      before-sleep = "${pkgs.swaylock-effects}/bin/swaylock -f";
      # Lock on lid close
      lock = "${pkgs.swaylock-effects}/bin/swaylock -f";
    };
    timeouts = [
      # Dim screen after 5 minutes
      {
        timeout = 300;
        command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      # Lock after 10 minutes
      {
        timeout = 600;
        command = "${pkgs.swaylock-effects}/bin/swaylock -f";
      }
      # Turn off displays after 15 minutes
      {
        timeout = 900;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
}
