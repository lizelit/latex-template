.PHONY: all build watch clean open

# メインのTeXファイル
MAIN = main

all: build

# 一度だけコンパイル（LuaLaTeX）
build:
	latexmk -lualatex $(MAIN).tex

# ファイルの変更を監視して自動コンパイル
watch:
	latexmk -pvc -lualatex $(MAIN).tex

# 生成されたファイルをクリーンアップ
clean:
	latexmk -C
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.synctex.gz

# PDFを開く（macOS）
open:
	open $(MAIN).pdf

# PDFを開く（Linux）
# open:
# 	zathura $(MAIN).pdf &
