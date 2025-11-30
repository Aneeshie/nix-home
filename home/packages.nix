{config, pkgs, ...}:

{
    home.packages = with pkgs; [
        git 
        neovim
        nodejs 
        python3
        curl
        wget 
        ripgrep
    ];
}
