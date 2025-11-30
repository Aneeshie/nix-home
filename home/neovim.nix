{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # empty because your GitHub repo already has all config
    extraConfig = "";
  };

  xdg.configFile."nvim".source = pkgs.fetchgit {
    url = "https://github.com/Aneeshie/nvim";
    ref = "main";
  };

}

