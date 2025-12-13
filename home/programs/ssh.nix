{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ssh = {
    enable = true;

    # Disable default config to avoid deprecation warning
    enableDefaultConfig = false;

    matchBlocks = {
      "meth" = {
        hostname = "10.0.0.76";
        user = "adi";
        identityFile = "~/.ssh/meth";
      };

      "github.com" = {
        identityFile = "~/.ssh/github";
      };
    };
  };
}
