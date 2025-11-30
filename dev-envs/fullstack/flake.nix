{
  description = "Dev Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          #--- JAVASCRIPT/TYPESCRIPT"
          pkgs.nodejs_22
          pkgs.pnpm
          pkgs.yarn
          pkgs.typescript
          pkgs.bun
          # useful JS utilities
          pkgs.esbuild
          pkgs.just

          # --- GO MICRO-SERVICES STACK ---
          pkgs.go
          pkgs.gopls
          pkgs.go-tools
          pkgs.protobuf
          pkgs.buf

          # --- DATABASE TOOLS ---
          # Postgres
          pkgs.postgresql
          pkgs.pgcli
          # MongoDB CLI
          pkgs.mongosh
          # Redis
          pkgs.redis

          # --- PRISMA ---
          pkgs.prisma-engines
          pkgs.prisma

          # --- RUST DEV ENV ---
          pkgs.rustc
          pkgs.cargo
          pkgs.clippy
          pkgs.rustfmt
          pkgs.pkg-config

          # --- DOCKER & CONTAINERS ---
          pkgs.docker
          pkgs.docker-compose

          # --- KUBERNETES WORLD ---
          pkgs.kubectl
          pkgs.k9s
          pkgs.helm
          pkgs.minikube

          # --- OTHER UTILITIES ---
          pkgs.git
          pkgs.curl
          pkgs.wget
          pkgs.jq
          pkgs.openssl
        ];

        # Environment variables or custom hooks
        shellHook = ''
          echo " Ultimate Fullstack Environment Activated!"
          echo "Node: $(node -v)"
          echo "Go: $(go version)"
          echo "Rust: $(rustc --version)"
          echo ""
          echo "Dev Environment Ready!!"
        '';
      };
    };
}
