{ config, pkgs, ... }:

{
  # Fingerprint authentication
  services.fprintd = {
    enable = true;
  };

  # Allow users in wheel group to enroll and verify fingerprints
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "net.reactivated.fprint.device.enroll" ||
           action.id == "net.reactivated.fprint.device.verify") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # PAM configuration for fingerprint authentication
  security.pam.services = {
    # Enable fingerprint for sudo
    sudo.fprintAuth = true;

    # Enable fingerprint for swaylock (with password fallback)
    swaylock.fprintAuth = true;
  };
}
