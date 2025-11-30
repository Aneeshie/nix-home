{
  description = "Competitive Programming & DSA environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.gcc
          pkgs.clang
          pkgs.cmake
          pkgs.gdb
          pkgs.valgrind
          pkgs.ccls

          # optional helpers
          pkgs.python3
        ];

        shellHook = ''
          echo "  DSA / Competitive Programming environment activated!"
        '';
      };
    };
}

