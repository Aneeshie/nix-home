{ pkgs, ... }:

{
# Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

# Smarter cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

# Modern replacement for ls
  programs.eza = {
    enable = true;
# enableZshIntegration sets up aliases automatically but our custom aliases in core/default.nix
# take precedence.
  };

# Terminal multiplexer
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    terminal = "screen-256color";
    baseIndex = 1;
# Feel free to add plugins or extra config here:
# plugins = with pkgs.tmuxPlugins; [ sensible vim-tmux-navigator ];
  };

# Resource monitor
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Default";
      theme_background = false; # true for transparent backgrounds
    };
  };

# GitHub CLI
  programs.gh = {
    enable = true;
  };

# Git TUI
  programs.lazygit = {
    enable = true;
  };

# JSON processor
  programs.jq = {
    enable = true;
  };

# Shell history syncing
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ]; # If you still want standard up-arrow history
  };

# Cross-shell prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = "$directory$git_branch$nix_shell$character";

      directory = {
        truncation_length = 2;
        truncate_to_repo = true;
        style = "blue";
      };

      git_branch = {
        format = " [$branch]($style)";
        style = "bright-black";
      };

      nix_shell = {
        format = " [󱄅 $name]($style)";
        style = "bold cyan";
        impure_msg = "impure";
        pure_msg = "pure";
      };

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
    };
  };
# Modern replacement for cat/highlight
  programs.bat = {
    enable = true;
  };

# Additional CLI tools not managed via `programs.*`
  home.packages = with pkgs; [
    tree-sitter
  ];
}
