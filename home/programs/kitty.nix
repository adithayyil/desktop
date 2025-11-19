{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "CommitMono";
      size = 13;
    };

    settings = {
      # Cursor
      cursor_shape = "block";

      # Window
      window_padding_width = 3;
      hide_window_decorations = "yes";

      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # Catppuccin Latte colors
      foreground = "#4c4f69";
      background = "#eff1f5";
      selection_foreground = "#eff1f5";
      selection_background = "#dc8a78";

      # Cursor colors
      cursor = "#dc8a78";
      cursor_text_color = "#eff1f5";

      # URL underline color
      url_color = "#1e66f5";

      # Kitty window border colors
      active_border_color = "#7287fd";
      inactive_border_color = "#9ca0b0";

      # Tab bar colors
      active_tab_foreground = "#eff1f5";
      active_tab_background = "#8839ef";
      inactive_tab_foreground = "#4c4f69";
      inactive_tab_background = "#bcc0cc";

      # Colors for marks
      mark1_foreground = "#eff1f5";
      mark1_background = "#7287fd";
      mark2_foreground = "#eff1f5";
      mark2_background = "#8839ef";
      mark3_foreground = "#eff1f5";
      mark3_background = "#209fb5";

      # Black
      color0 = "#5c5f77";
      color8 = "#6c6f85";

      # Red
      color1 = "#d20f39";
      color9 = "#d20f39";

      # Green
      color2 = "#40a02b";
      color10 = "#40a02b";

      # Yellow
      color3 = "#df8e1d";
      color11 = "#df8e1d";

      # Blue
      color4 = "#1e66f5";
      color12 = "#1e66f5";

      # Magenta
      color5 = "#ea76cb";
      color13 = "#ea76cb";

      # Cyan
      color6 = "#179299";
      color14 = "#179299";

      # White
      color7 = "#acb0be";
      color15 = "#bcc0cc";
    };
  };
}
