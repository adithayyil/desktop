{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.copyparty = {
    enable = true;

    package = pkgs.copyparty.override {
      ffmpeg = pkgs.ffmpeg;
    };

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
          rwd = [ "adi" ];
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/store 0755 copyparty copyparty -"
  ];
}
