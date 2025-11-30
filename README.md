# Home Manager flake

This repository is your Home Manager configuration, defined as a Nix flake. It manages user-level packages, programs (git, zsh, starship, Neovim), terminal config (Ghostty), and provides convenient development shells for DSA and full‑stack work.

> **Note on platforms**
> - The Home Manager config and dev shells are currently wired to `aarch64-darwin` (Apple Silicon macOS).
> - They **can** be adapted to Linux or other systems by changing the `system` value in the flakes (see below), but as written they are macOS‑specific.

## Layout
- `flake.nix`
  - Defines `homeConfigurations."zerr"` using Home Manager.
  - Hardcodes `system = "aarch64-darwin"` and imports modules from `home/`.
- `home/`
  - `default.nix`: Basic user info and `home.stateVersion`.
  - `packages.nix`: Packages installed into your user profile (`home.packages`).
  - `programs.nix`: Program configs, currently git and starship.
  - `shell.nix`: Zsh config (completion, autosuggestions, syntax highlighting, aliases like `hm`, `devdsa`, `devfs`).
  - `ghostty.nix`: Wires `configs/ghostty.conf` into `~/.config/ghostty/config`.
  - `neovim.nix`: Enables Neovim and points `~/.config/nvim` at `Aneeshie/nvim` repo.
- `configs/ghostty.conf`: Ghostty terminal configuration.
- `dev-envs/`
  - `dsa/flake.nix`: DSA / competitive programming dev shell.
  - `fullstack/flake.nix`: Full‑stack dev shell with JS/TS, Go, Rust, DB tooling, Docker, Kubernetes, etc.

> `home.nix` in the repo is **not** used by the flake: `flake.nix` only imports modules from `home/`. You can ignore `home.nix` or delete it once you are confident you no longer need the template.

## Prerequisites
1. **Nix installed**
   - Install Nix following the official instructions.
2. **Flakes enabled**
   - In `/etc/nix/nix.conf` or `~/.config/nix/nix.conf`:
     ```
     experimental-features = nix-command flakes
     ```
3. **Home Manager available as a flake**
   - You do **not** need the channel-based Home Manager install; this repo pulls `home-manager` via `inputs.home-manager` in `flake.nix`.
4. **Git installed**
   - You should be comfortable cloning this repo and pushing changes.

### macOS vs Linux
- As written, `flake.nix` uses:
  ```nix
  system = "aarch64-darwin";
  pkgs = nixpkgs.legacyPackages.${system};
  ```
- The dev env flakes under `dev-envs/` also pin `system = "aarch64-darwin"`.
- To use this on Linux (e.g. x86_64), you would need to:
  - Change `system` to something like `"x86_64-linux"` in `flake.nix` and both `dev-envs/*/flake.nix` files.
  - Adjust any macOS‑specific paths (e.g. `home.homeDirectory = "/Users/zerr";`) to your Linux home, like `/home/zerr`.

## Identity & security precautions
Before running this config on a new machine or user account, review:

### 1. Git identity
Git is configured in `home/programs.nix`:

- `programs.git.settings.user.name = "Aneeshie";`
- `programs.git.settings.user.email = "aneeshdas556@gmail.com";`

You **must** change these to your own details before committing from this machine:

```nix
programs.git = {
  enable = true;
  settings.user.name = "Your Name";
  settings.user.email = "you@example.com";
};
```

Alternatively (outside Home Manager), configure git manually:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 2. SSH/GPG keys
- Do **not** commit private keys into this repository.
- If you reference SSH/GPG keys in any future modules, ensure the paths are correct for the current machine and that the keys are safe to use here.

### 3. Secrets & tokens
- Keep API keys, access tokens, and passwords **out** of version control.
- Prefer:
  - environment variables,
  - password manager / secret manager,
  - untracked local files (.gitignored).

### 4. Machine‑specific paths
- `home/default.nix` hardcodes:
  ```nix
  home.username = "zerr";
  home.homeDirectory = "/Users/zerr";
  ```
- On another machine or OS, update these to your actual username and home directory.

## Initial setup
1. **Clone the repo**
   ```bash
   git clone https://github.com/Aneeshie/nix-home ~/.config/home-manager
   cd ~/.config/home-manager
   ```

2. **Review and edit configuration**
   - Check and update:
     - `home/default.nix` for username and home directory.
     - `home/programs.nix` for git username/email.
     - `home/neovim.nix` to confirm you actually want to use `Aneeshie/nvim` and that the `sha256` pin is still valid.
     - `home/ghostty.nix` and `configs/ghostty.conf` for terminal behavior.
   - Optionally remove `home.nix` if you don’t intend to use the template.

3. **Activate Home Manager via flake**
   From the repository root:

   ```bash
   home-manager switch --flake .#zerr
   ```

   - The `homeConfigurations."zerr"` output is defined in `flake.nix`, so you target `.#zerr`.
   - On first run, Home Manager may ask to create/modify your profile; follow the prompts.

## Shell shortcuts (`hm`, `devdsa`, `devfs`)
Defined in `home/shell.nix`:

- `hm`
  ```bash
  hm        # alias for: home-manager switch --flake ~/.config/home-manager
  ```
  - Quickly rebuilds and activates your Home Manager config from this repo.

- `devdsa`
  ```bash
  devdsa    # alias for: nix develop ~/.config/home-manager/dev-envs/dsa
  ```
  - Drops you into the DSA / competitive programming dev shell.
  - Uses packages defined in `dev-envs/dsa/flake.nix` (GCC, Clang, CMake, GDB, ccls, Python, etc.).

- `devfs`
  ```bash
  devfs     # alias for: nix develop ~/.config/home-manager/dev-envs/fullstack
  ```
  - Drops you into the full‑stack dev shell with:
    - Node.js, pnpm, yarn, TypeScript, bun, esbuild, just.
    - Go toolchain (go, gopls, go‑tools, protobuf, buf).
    - Databases tooling (PostgreSQL, pgcli, mongosh, redis).
    - Prisma, Rust toolchain, Docker & docker-compose, Kubernetes tools (kubectl, k9s, helm, minikube), and common CLI utilities.

These aliases only exist in shells managed by Home Manager (i.e. after `programs.zsh` is enabled through this configuration).

## Using the development environments directly
Without the aliases, you can still use the dev shells:

- **DSA shell**
  ```bash
  cd ~/.config/home-manager/dev-envs/dsa
  nix develop
  ```

- **Fullstack shell**
  ```bash
  cd ~/.config/home-manager/dev-envs/fullstack
  nix develop
  ```

## Common Home Manager operations
- Apply changes:
  ```bash
  home-manager switch --flake .#zerr
  ```

- Dry‑run build without switching:
  ```bash
  home-manager build --flake .#zerr
  ```

- List and roll back to previous generations:
  ```bash
  home-manager generations
  home-manager switch --generation <number>
  ```

## Troubleshooting
- **`home-manager` command not found**
  - Ensure Home Manager is installed via flakes and that your shell `PATH` includes your Nix profile bin directory.
- **Flake evaluation errors**
  - Check for typos or missing imports in `.nix` files.
  - Validate that all referenced files (e.g. `configs/ghostty.conf`) exist.
- **Wrong identity in commits**
  - Double‑check `programs.git.settings.user.*` and/or global git config before committing.
- **Platform issues**
  - If you change `system` to a Linux value, be sure to revisit any macOS‑specific assumptions (paths, tools, etc.) and adjust accordingly.
