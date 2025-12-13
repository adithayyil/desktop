{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Laptop lid behavior
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "suspend";
  };

  # Disable X11
  services.xserver.enable = false;
}
