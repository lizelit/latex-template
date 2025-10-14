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

        # レポート用のTeXパッケージ（LuaLaTeX対応）
        tex = pkgs.texlive.combine {
          inherit
            (pkgs.texlive)
            scheme-full # SI単位系
            luatex
            luatexja
            luatexbase
            collection-langjapanese
            latexmk
            ;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            tex
            texlab # LaTeX LSP
            gnumake
          ];

          shell = "${pkgs.zsh}/bin/zsh";

          shellHook = ''
            echo "LaTeX Lab Report Environment"
            echo ""
            echo "Commands:"
            echo "  make build  - compile"
            echo "  make watch  - auto compile"
            echo "  make clean  - clean up directory"
            echo "  make open   - open pdf"
            echo ""
            echo "LSP (texlab) is available for Neovim"
          '';
        };
      }
    );
}
