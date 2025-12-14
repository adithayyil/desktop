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

    volumes = {
      "/" = {
        path = "/srv/store";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/copyparty 0755 copyparty copyparty -"
  ];
}
