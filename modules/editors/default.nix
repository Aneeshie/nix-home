{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true; # Replaces EDITOR="emacs" or "vim" in session variables
  };

  # Fetch the Neovim configuration directly from GitHub.
  # Note: This creates a read-only symlink in ~/.config/nvim.
  # If you want to make local edits to your nvim config frequently,
  # it's better to clone the repository manually to ~/.config/nvim 
  # and remove this xdg.configFile block.
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "Aneeshie";
    repo = "nvim";
    rev = "066f3bb47cd0725727fb650a8b17501dd18ff509";
    sha256 = "07c3dfmlc7d1bnrnhsllvqcj5y4zccc4zljbjc3i302f5ls4prgw";
  };
}
