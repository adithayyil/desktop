{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Keep server running when lid is closed
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
}
