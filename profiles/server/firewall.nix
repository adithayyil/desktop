{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.firewall = {
    enable = true;

    # SSH
    allowedTCPPorts = [ 22 ];

    # Common service ports (add as needed)
    # allowedTCPPorts = [ 80 443 ]; # HTTP/HTTPS
    # allowedUDPPorts = [ 51820 ];   # WireGuard

    # Log dropped packets (useful for debugging)
    logRefusedConnections = true;
  };
}
