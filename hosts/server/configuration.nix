{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Hardware configuration
    # cp the hardware-configuration.nix from /etc
    # ./hardware.nix

    # Common modules
    ../../common/boot.nix
    ../../common/networking.nix
    ../../common/users.nix
    ../../common/fonts.nix
    ../../common/nix.nix

    # Server profile
    ../../profiles/server
  ];

  # Server-specific: Static IP configuration
  # Note: Adjust interface name (eth0/ens18/etc.) based on your hardware
  networking.networkmanager.enable = false;
  networking.interfaces.eth0.ipv4.addresses = [
    {
      address = "192.168.1.100"; # Adjust to your network
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    htop
    ncdu
  ];

  # [!!DO NOT CHANGE!!] NixOS release version [!!DO NOT CHANGE!!]
  system.stateVersion = "25.05";
}
