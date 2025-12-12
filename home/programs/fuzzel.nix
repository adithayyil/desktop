{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        # Add any main settings here if needed
      };

      border = {
        radius = 0;
      };

      colors = {
        background = "eff1f5dd";
        text = "4c4f69ff";
        prompt = "5c5f77ff";
        placeholder = "8c8fa1ff";
        input = "4c4f69ff";
        match = "7287fdff";
        selection = "acb0beff";
        selection-text = "4c4f69ff";
        selection-match = "7287fdff";
        counter = "8c8fa1ff";
        border = "7287fdff";
      };
    };
  };
}
