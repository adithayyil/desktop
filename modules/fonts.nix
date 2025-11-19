{ config, lib, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    inter
    commit-mono
    font-awesome
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Inter" ];
    sansSerif = [ "Inter" ];
    monospace = [ "CommitMono" ];
  };
}
