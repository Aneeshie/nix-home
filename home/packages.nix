{config, pkgs, ...}:

{

  home.packages = with pkgs; [
    git
      vim
      bash
      zsh
      cloc
      entr
      eza
      fd
      fnm
      gum
      fzf
      gh
      glow
      gnupg
      highlight
      btop
      jq
      lazygit
      python3
      ripgrep
      shellcheck
      stylua
      tmux
      tree
      wdiff
      wget
      zoxide
      sesh
      ];
}
