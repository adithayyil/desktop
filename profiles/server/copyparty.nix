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
      shr = "/share";
      shr-adm = "adi";
      xff-hdr = "cf-connecting-ip";
      xff-src = "127.0.0.1,::1";
      rproxy = 1;
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
