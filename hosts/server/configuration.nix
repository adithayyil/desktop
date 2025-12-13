{
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Hardware configuration
    ./hardware.nix

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
      address = "10.0.0.76";
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

  # Trust this machine's nix store for deployments
  nix.settings.trusted-users = [ "adi" "root" ];

  # [!!DO NOT CHANGE!!] NixOS release version [!!DO NOT CHANGE!!]
  system.stateVersion = "25.05";
}
