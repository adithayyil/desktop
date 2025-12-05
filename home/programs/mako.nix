{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      # Colors
      background-color = "#eff1f5";
      text-color = "#4c4f69";
      border-color = "#7287fd";
      progress-color = "over #9ca0b0";

      # Layout
      anchor = "top-right";
      width = 350;
      height = 150;
      margin = "10";
      padding = "15";
      border-size = 2;
      border-radius = 0;

      # Icons
      icons = true;
      max-icon-size = 48;

      # Behavior
      default-timeout = 5000;
      ignore-timeout = false;

      # Font
      font = "Inter 11";

      # Grouped notifications
      group-by = "app-name";

      # Urgency styling
      "urgency=low" = {
        border-color = "#9ca0b0";
        default-timeout = 3000;
      };

      "urgency=normal" = {
        border-color = "#7287fd";
        default-timeout = 5000;
      };

      "urgency=critical" = {
        border-color = "#d20f39";
        background-color = "#d20f39";
        text-color = "#eff1f5";
        default-timeout = 0;
      };
    };
  };
}
