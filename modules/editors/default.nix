{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true; # Replaces EDITOR="emacs" or "vim" in session variables
  };

}
