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
    sha256 = "sha256-2n8D1+T+azCD1i9Wc/850JnbVImzIpb7IE2XH1kwim0=";
  };
}

