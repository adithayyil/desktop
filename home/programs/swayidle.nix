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
      before-sleep = "${pkgs.swaylock-effects}/bin/swaylock -f";
      lock = "${pkgs.swaylock-effects}/bin/swaylock -f";
    };
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -e '.nodes[].nodes[].nodes[] | select(.focused==true and .fullscreen_mode==1)' > /dev/null || ${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -e '.nodes[].nodes[].nodes[] | select(.focused==true and .fullscreen_mode==1)' > /dev/null || ${pkgs.swaylock-effects}/bin/swaylock -f";
      }
      {
        timeout = 900;
        command = "${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -e '.nodes[].nodes[].nodes[] | select(.focused==true and .fullscreen_mode==1)' > /dev/null || ${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
}
