{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.openssh = {
    enable = true;

    settings = {
      # Disable password auth (keys only)
      PasswordAuthentication = false;
      PermitRootLogin = "no";

      # Security hardening
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;

      # Performance
      UseDns = false;
    };

    # Default SSH port
    ports = [ 22 ];
  };

  # Allow SSH through PAM for specific users
  users.users.adi.openssh.authorizedKeys.keys = [ ];


  # Fail2ban for SSH brute-force protection
  services.fail2ban = {
    enable = true;
    ignoreIP = [
      "127.0.0.1/8"
      "192.168.1.0/24" # Your LAN
    ];
  };
}
