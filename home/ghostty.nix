{ config, pkgs, ... }:

{
  xdg.configFile."ghostty/config".source = ../configs/ghostty.conf;
  #xdg.configFile."ghostty/keybinds".source = ../configs/ghostty-keybinds;
}

