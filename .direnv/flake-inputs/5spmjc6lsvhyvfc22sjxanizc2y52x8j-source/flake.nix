{
  description = "LaTeX development environment for lab reports";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        tex = pkgs.texlive.combine {
          inherit
            (pkgs.texlive)
            scheme-small
            luatex
            luatexja
            collection-langjapanese
            collection-latexrecommended
            collection-latexextra
            latexmk
            ;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            tex
            texlab
            noto-fonts
            noto-fonts-cjk-sans
          ];

          shell = "${pkgs.zsh}/bin/zsh";

          shellHook = ''
            echo "LuaLaTeX environment ready"
            echo "  latexmk      : build"
            echo "  latexmk -pvc : watch"
          '';
        };

        apps = {
          build = {
            type = "app";
            program = "${pkgs.writeShellScript "build" ''
              unset SOURCE_DATE_EPOCH
              latexmk -lualatex main.tex
              ''}";
          };

          watch = {
            type = "app";
            program = "${pkgs.writeShellScript "watch" ''
              latexmk -pvc -lualatex main.tex
            ''}";
          };

          clean = {
            type = "app";
            program = "${pkgs.writeShellScript "clean" ''
                latexmk -c
              ''}";
          };
        };

      packages.default = pkgs.stdenv.mkDerivation {
        name = "report";
        src = ./.;
        buildPhase = ''
          latexmk -lualatex main.tex
          '';
        buildInputs = [ tex ];
        installPhase = ''
          mkdir -p $out
          cp main.pdf $out/
        '';

      };
      }
    );
}
