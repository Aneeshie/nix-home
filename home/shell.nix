{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      hm = "home-manager switch --flake ~/.config/home-manager";
      devfs = "nix develop ~/.config/home-manager/dev-envs/fullstack";
      devdsa = "nix develop ~/.config/home-manager/dev-envs/dsa";
      ls = "eza";
      l = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      cd = "z";
    };

  };
}

