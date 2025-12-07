{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "adithayyil";
    userEmail = "adithayyil@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      url."git@github.com:".insteadOf = "https://github.com/";
    };
  };
}
