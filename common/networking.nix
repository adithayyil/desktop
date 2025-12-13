{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:

{
  networking.hostName = hostname;

  time.timeZone = "America/Toronto";
}
