{
  description = "LaTeX development environment for lab reports";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # レポート用のTeXパッケージ（LuaLaTeX対応）
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) 
            scheme-medium
            # LuaLaTeX + 日本語サポート
            luatex
            luatexja
            luatexbase
            collection-langjapanese
            # コンパイルツール
            latexmk
            # レポートでよく使うパッケージ
            listings       # コード表示
            xcolor         # 色付き
            here           # 図の配置制御
            float          # 図表の配置
            caption        # キャプション
            subcaption     # サブキャプション
            graphicx       # 画像
            amsmath        # 数式
            amssymb        # 数学記号
            geometry       # ページレイアウト
            hyperref       # ハイパーリンク
            booktabs       # 綺麗な表
            multirow       # 表の結合
            siunitx        # SI単位系
            ;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            tex
            texlab  # LaTeX LSP
            gnumake
          ];

          shellHook = ''
            echo "LaTeX Lab Report Environment"
            echo ""
            echo "Commands:"
            echo "  make build  - コンパイル"
            echo "  make watch  - 自動コンパイル（変更を監視）"
            echo "  make clean  - 一時ファイル削除"
            echo "  make open   - PDFを開く"
            echo ""
            echo "LSP (texlab) is available for Neovim"
          '';
        };
      }
    );
}
