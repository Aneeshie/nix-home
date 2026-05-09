{ config, pkgs, ... }:

{
  # Link Ghostty terminal config
  xdg.configFile."ghostty/config".source = ../../configs/ghostty.conf;
}
