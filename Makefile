.PHONY: check fmt

check:
	find . -name "*.nix" -exec deadnix {} \;

optimize:
	find . -name "*.nix" -exec deadnix -eq {} \;

fmt:
	find . -name "*.nix" -exec nixfmt {} \;
