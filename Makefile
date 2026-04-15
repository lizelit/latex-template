build:
	nix run .#build

watch:
	nix run .#watch

clean:
	nix run .#clean

open:
	open -a Skim main.pdf
