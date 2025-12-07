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
      # Enable vi mode
      set -o vi

      # Better tab completion
      bind 'set completion-ignore-case on'
      bind 'set show-all-if-ambiguous on'

      # Simple colored prompt: [user@host:~]$
      PS1='\[\033[01;32m\][\u@\h\[\033[01;34m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
    '';
  };
}
