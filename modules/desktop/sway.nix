{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ ]; # Packages managed by home-manager
  };

  # For screen sharing and file pickers
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
