# Darkone framework just file

#alias c := clean
#alias f := fix
#alias g := generate

generatedHostFile := './var/generated/hosts.nix'
nixKeyDir := './var/security/ssh'
nixKeyFile := nixKeyDir + '/id_ed25519_nix'

# Justfile help
_default:
	@just --list

# Framework installation (wip)
install:
	#!/usr/bin/env bash
	if [ ! -d {{nixKeyDir}} ] ;then
		echo "-> Creating {{nixKeyDir}} directory..."
		mkdir -p {{nixKeyDir}}
	fi
	if [ ! -f {{nixKeyFile}} ] ;then
	  echo "-> Creating ssh keys..."
		ssh-keygen -t ed25519 -f {{nixKeyFile}} -N ""
	else
		echo "-> Maintenance ssh key already exists."
	fi
	if [ ! -d ./src/vendor ] ;then
		echo "-> Building generator..."
		cd ./src && composer install --no-dev && cd ..
	else
		echo "-> Generator is ok."
	fi
	ssh-add {{nixKeyFile}}
	echo "-> Done"

# fix + generate + check
clean: fix generate check

# Check nix files with deadnix
check:
	@echo "Checking nix files with deadnix..."
	find . -name "*.nix" -exec deadnix {} \;

# Check the main flake
flake-check:
	nix flake check

# format (nixfmt) + optimize (deadnix)
fix: format optimize

# Recursive nixfmt on all nix files
format:
	find . -name "*.nix" -exec nixfmt {} \;

# Recursive deadnix on all nix files
optimize:
	find . -name "*.nix" -exec deadnix -eq {} \;

# Update the nix generated files
generate: _gen-default-modules _gen-default-overlays _gen-hosts

# Generate default.nix of lib/modules dir
_gen-default-modules:
	#!/usr/bin/env bash
	echo "-> generating modules default.nix..."
	cd lib/modules
	echo "{ imports = [" > default.nix
	find . -name "*.nix" | grep -v default.nix >> default.nix
	echo "];}" >> default.nix
	nixfmt default.nix

# Generate default.nix of lib/overlays
_gen-default-overlays:
	#!/usr/bin/env bash
	echo "-> generating overlays default.nix..."
	cd lib/overlays
	echo "{ imports = [" > default.nix
	ls *.nix | grep -v default.nix >> default.nix
	echo "];}" >> default.nix
	nixfmt default.nix

# Generate var/generated/hosts.nix
# TODO: generate with nix generator
_gen-hosts:
	#!/usr/bin/env bash
	echo "-> generating hosts..."
	echo "# This file is generated by 'just generate'" > "{{generatedHostFile}}"
	echo "# from the configuration file usr/config.yaml" >> "{{generatedHostFile}}"
	echo "# --> DO NOT EDIT <--" >> "{{generatedHostFile}}"
	echo >> "{{generatedHostFile}}"
	php ./src/generator.php >> "{{generatedHostFile}}"
	nixfmt "{{generatedHostFile}}"

# Copy local id on a new node (wip)
ssh-copy-id host:
	#!/usr/bin/env bash
	ssh-copy-id -i "{{nixKeyFile}}.pub" -t /home/nix/.ssh/authorized_keys {{host}}
	ssh {{host}} 'chown -R nix:users /home/nix/.ssh'

