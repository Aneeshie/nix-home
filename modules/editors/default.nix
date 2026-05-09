{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true; # Replaces EDITOR="emacs" or "vim" in session variables
  };

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "Aneeshie";
    repo = "nvim";
    rev = "0cc89ce58c10b8e04d4db2565d3abe96d75914d8";
    sha256 = "1qjrcps91jnl4kqhx21x8fgmvlf0yp7zhqvbgl7k2dj4h6gqv1pp";
  };
}
