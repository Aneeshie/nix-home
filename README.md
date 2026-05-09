# ❄️ Nix Home

Welcome to my **Nix + Home Manager** configuration! This repository manages my entire dotfiles, developer tools, shell configurations, and environment declaratively.

If you are new to Nix and want to learn how to set up an easily reproducible, declarative system for your machine (especially macOS), this guide is for you!

---

## ✨ Features
- **Declarative Environments:** No more "it works on my machine". Dependencies and tool versions are locked and reproducible.
- **Modular Structure:** Configurations are logically separated into `core`, `tools`, `editors`, and `terminals`.
- **Modern CLI Utilities:** Uses `eza` (ls replacement), `fzf`, `zoxide` (smart cd), `bat`, `btop`, and `atuin` natively synced to `zsh`.
- **Pre-configured Neovim:** Pulls an optimized Neovim config directly from GitHub.
- **Rollbacks:** Break something? Roll back to the previous generation instantly.

---

## 📁 Folder Structure

```text
.
├── flake.nix              # The entry point of the configuration
├── flake.lock             # Locks all dependencies to specific commits
├── configs/               # Manual config files (e.g., Ghostty config)
├── dev-envs/              # Project-specific Nix development environments
└── modules/               # The meat of the configuration
    ├── home.nix           # Main home-manager entrypoint (imports submodules)
    ├── core/              # Core tools (git, zsh, aliases, core CLI packages)
    ├── editors/           # Editor configurations (Neovim)
    ├── terminals/         # Terminal configurations (Ghostty)
    └── tools/             # Modern CLI utilities (fzf, zoxide, eza, tmux, etc.)
```

---

## 🚀 Quick Start & Installation

If you've never used Nix before, follow these steps in order.

### 1. Install Nix
The easiest way to install Nix on macOS or Linux is via the [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer). It handles enabling Flakes automatically!

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

*Note: Restart your terminal after installation!*

### 2. Enable Flakes (If you used the official Nix installer)
If you used the official Nix installer instead of Determinate Systems, you need to enable Flakes manually.
Open `~/.config/nix/nix.conf` (create the directory/file if it doesn't exist) and add:
```text
experimental-features = nix-command flakes
```

### 3. Install Home Manager
Home Manager is a tool that manages your `~` (home) directory using Nix. You can run it directly via `nix run`. You do not need a separate Home Manager installation command because this repository leverages Flakes.

### 4. Clone and Apply This Configuration
First, clone the repository to your home folder:
```bash
git clone https://github.com/Aneeshie/nix-home.git ~/nix-home
cd ~/nix-home
```

*(Optional) If your username is not `aneeshie` or your OS is not macOS (aarch64-darwin), edit `flake.nix` and `modules/home.nix` to replace the username, path, and system architecture respectively.*

Now, apply the configuration:
```bash
nix run home-manager/master -- switch --flake ~/nix-home#aneeshie
```

Once applied, you can use the custom alias `hm` from anywhere to rebuild your system:
```bash
hm
```

---

## 📖 Important Concepts for Beginners

- **Nix:** A package manager that ensures reproducible builds. It stores packages in `/nix/store` with cryptographic hashes, meaning multiple versions of a package can co-exist without conflicts.
- **Flakes:** A feature in Nix that guarantees reproducibility by locking dependencies in a `flake.lock` file. Think of it like `package-lock.json` for your entire OS environment.
- **Home Manager:** A tool that extends Nix to manage user-specific dotfiles, programs, and services. Instead of manually editing `~/.zshrc` or `~/.config/tmux/tmux.conf`, you declare how they should look in `.nix` files, and Home Manager generates the real files for you.
- **Generations:** Every time you apply your configuration (using `hm`), Home Manager creates a "generation". You can always roll back to an older generation if a new update breaks things.

---

## 🛠️ Daily Usage

### Updating Packages
To update your packages to their latest versions, you need to update the `flake.lock` file and switch:
```bash
cd ~/nix-home
nix flake update
hm
```

### Rolling Back
If an update broke your system, list your previous generations:
```bash
home-manager generations
```
To switch to a specific generation:
```bash
home-manager switch --flake ~/nix-home#aneeshie --generation <number>
```
To switch to the previous generation instantly:
```bash
home-manager switch --flake ~/nix-home#aneeshie --rollback
```

### How to Customize
1. **Adding a Package:** Open `modules/core/default.nix` and add the package name under `home.packages`. Search for available packages on [NixOS Packages](https://search.nixos.org/packages).
2. **Configuring a Tool:** Open `modules/tools/default.nix`. If a program has a module (e.g., `programs.tmux.enable = true;`), you can define its settings directly in Nix. Use the [Home Manager Option Search](https://home-manager-options.extranix.com/) to find available options.

---

## ❓ FAQs & Troubleshooting

**Q: I get a "flake not found" error when running `hm`.**
Make sure your configuration is located at `~/nix-home`. If you cloned it elsewhere, update the alias inside `modules/core/default.nix`.

**Q: Home Manager is complaining about existing dotfiles (e.g., `~/.zshrc already exists`).**
Home Manager refuses to overwrite existing files to prevent data loss. You should back up and remove the conflicting file:
```bash
mv ~/.zshrc ~/.zshrc.bak
hm
```

**Q: Why can't I edit `~/.config/nvim`?**
This setup pulls the Neovim configuration directly from GitHub, making the folder a read-only symlink to the Nix store. If you want to modify your Neovim configuration locally:
1. Remove the `xdg.configFile."nvim"` block from `modules/editors/default.nix`.
2. Run `hm`.
3. Manually clone your Neovim repo into `~/.config/nvim`.

**Q: Why are my shell aliases not working immediately?**
After running `hm`, changes to your shell usually require restarting the terminal or sourcing the shell profile:
```bash
source ~/.zshrc
```
