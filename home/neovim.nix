{ pkgs, ... }:

let
  nvimConfig = pkgs.fetchGit {
    url = "https://github.com/Aneeshie/nvim";
    rev = "main";
  };
in {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Use your repo's full config, so no default Nix config
    configure.customRC = "";
  };

  xdg.configFile."nvim".source = nvimConfig;
}

