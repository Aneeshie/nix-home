{config, pkgs, ...}:

{
    home.packages = with pkgs; [
        git 
        nodejs 
        python3
        curl
        wget 
        ripgrep
    ];
}
