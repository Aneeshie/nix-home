{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      hm = "home-manager switch --flake ~/.config/home-manager";
      devfs = "nix develop ~/.config/home-manager/dev-environments/fullstack";
      devdsa = "nix develop ~/.config/home-manager/dev-environments/dsa";
    };
  };
}

