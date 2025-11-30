{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = "";
  };

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "Aneeshie";
    repo = "nvim";
    rev = "main";
  };
}

