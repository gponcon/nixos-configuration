.PHONY: check optimize fmt modules-default overlays-default
.ONESHELL:

all: fix defaults check

check:
	find . -name "*.nix" -exec deadnix {} \;

flake-check:
	nix flake check

fix: fmt optimize

fmt:
	find . -name "*.nix" -exec nixfmt {} \;

optimize:
	find . -name "*.nix" -exec deadnix -eq {} \;

defaults: modules-default overlays-default

modules-default:
	cd lib/modules
	echo "{ imports = [" > default.nix
	find . -name "*.nix" | grep -v default.nix >> default.nix
	echo "];}" >> default.nix
	nixfmt default.nix

overlays-default:
	cd lib/overlays
	echo "{ imports = [" > default.nix
	ls *.nix | grep -v default.nix >> default.nix
	echo "];}" >> default.nix
	nixfmt default.nix

