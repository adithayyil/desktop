{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.copyparty = {
    enable = true;

    settings = {
      i = "0.0.0.0";
      p = 8080;
    };

    accounts = {
      adi = {
        passwordFile = config.sops.secrets."copyparty/adi".path;
      };
    };

    volumes = {
      "/" = {
        path = "/srv/store";
        access = {
          rw = [ "adi" ];
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/store 0755 copyparty copyparty -"
  ];
}
