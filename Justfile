alias c := clean
alias f := fix
alias d := defaults

# Justfile help
default:
	@just --list

# fix + defaults + check
clean: fix defaults check

# Check nix files with deadnix
check:
	@echo "Checking nix files with deadnix..."
	find . -name "*.nix" -exec deadnix {} \;

# Check the main flake
flake-check:
	nix flake check

# fmt (nixfmt) + optimize (deadnix)
fix: fmt optimize

# Recursive nixfmt on all nix files
fmt:
	find . -name "*.nix" -exec nixfmt {} \;

# Recursive deadnix on all nix files
optimize:
	find . -name "*.nix" -exec deadnix -eq {} \;

# Generate all default.nix files
defaults: default-modules default-overlays

# Generate default.nix of lib/modules dir
default-modules:
	#!/usr/bin/env bash
	echo "-> generating modules default.nix..."
	cd lib/modules
	echo "{ imports = [" > default.nix
	find . -name "*.nix" | grep -v default.nix >> default.nix
	echo "];}" >> default.nix
	nixfmt default.nix

# Generate default.nix of lib/overlays
default-overlays:
	#!/usr/bin/env bash
	echo "-> generating overlays default.nix..."
	cd lib/overlays
	echo "{ imports = [" > default.nix
	ls *.nix | grep -v default.nix >> default.nix
	echo "];}" >> default.nix
	nixfmt default.nix

