{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      "copyparty/adi" = {
        owner = "copyparty";
        mode = "0400";
      };

      "cloudflared/credentials" = {
        mode = "0400";
      };
    };
  };
}
