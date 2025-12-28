{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim

        ms-python.python
        rust-lang.rust-analyzer
        golang.go
        jnoortheen.nix-ide

        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];

      userSettings = {
        "editor.fontSize" = 16;
        "editor.fontFamily" = "'CommitMono', 'monospace'";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "selection";

        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Catppuccin Latte";
        "workbench.iconTheme" = "catppuccin-latte";

        "terminal.integrated.fontFamily" = "'CommitMono'";
        "terminal.integrated.fontSize" = 13;

        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
      };
    };
  };
}
