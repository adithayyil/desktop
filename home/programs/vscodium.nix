{ config, pkgs, lib, ... }:

{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "vscodium-wayland";
      paths = [ pkgs.vscodium ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/codium \
          --add-flags "--enable-features=UseOzonePlatform,WaylandWindowDecorations" \
          --add-flags "--ozone-platform=wayland"
      '';
    })
  ];

  # Make Electron apps prefer Wayland
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
