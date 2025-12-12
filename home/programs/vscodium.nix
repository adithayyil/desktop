{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Language support
        ms-python.python
        rust-lang.rust-analyzer
        golang.go
        jnoortheen.nix-ide

        # Tools

        # Themes
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];

      userSettings = {
        # Editor settings
        "editor.fontSize" = 16;
        "editor.fontFamily" = "'CommitMono', 'monospace'";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "selection";

        # Workbench
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Catppuccin Latte";
        "workbench.iconTheme" = "catppuccin-latte";

        # Terminal
        "terminal.integrated.fontFamily" = "'CommitMono'";
        "terminal.integrated.fontSize" = 13;

        # Files
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
      };
    };
  };
}
