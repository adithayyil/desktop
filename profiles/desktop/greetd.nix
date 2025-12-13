{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --theme border=#8839ef;text=#4c4f69;prompt=#8839ef;time=#6c6f85;action=#8839ef;button=#4c4f69;container=#eff1f5;input=#e6e9ef;background=#eff1f5 --cmd sway";
        user = "greeter";
      };
    };
  };
}
