{ config, pkgs, lib, ... }:

{
  programs.bash = {
    enable = true;

    # History settings
    historyControl = [ "ignoredups" "ignorespace" ];
    historyFile = "${config.home.homeDirectory}/.bash_history";
    historyFileSize = 10000;
    historySize = 10000;

    # Shell options
    initExtra = ''
      # Better tab completion
      bind 'set completion-ignore-case on'
      bind 'set show-all-if-ambiguous on'
    '';
  };

  programs.starship = {
    enable = true;
  };
}
