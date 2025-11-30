{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "Aneeshie";
    settings.user.email = "aneeshdas556@gmail.com";
  };

  programs.starship.enable = true;
}

