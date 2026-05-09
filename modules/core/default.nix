{ pkgs, ... }:

{
  # Core packages that don't need dedicated module configurations
  home.packages = with pkgs; [
    bash
    cloc
    entr
    fd
    fnm
    gum
    glow
    gnupg
    python3
    ripgrep
    shellcheck
    stylua
    tree
    wdiff
    wget
    sesh
  ];

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Aneeshie";
        email = "aneeshdas556@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # We use eza for modern ls replacements
    shellAliases = {
      # Use an absolute path for flake to ensure it can be run from anywhere
      hm = "home-manager switch --flake ~/nix-home";
      devfs = "nix develop ~/nix-home/dev-envs/fullstack";
      devdsa = "nix develop ~/nix-home/dev-envs/dsa";
      ls = "eza";
      l = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      cd = "z"; # alias to zoxide
    };
  };
}
