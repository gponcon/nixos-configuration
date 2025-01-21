# The usr directory

This directory contains all files specific to the local network (host and user profiles, machines, configuration, add-ons, etc.).

> [!NOTE]
> This is where you can modify files.

- **networks:** configuration files for networks
- **users:** additional or overloaded user profiles
- **hosts:** additional or overloaded host profiles
- **machines:** machine-specific configurations (hardware, etc.)
- **modules:** additional or completed modules
- **secrets:** your keys and passwords (sops)

> [!caution]
> **Multiple network declaration:**
> 
> The `config.yaml` contains a network declarations: hosts, users and network configuration. To manage several networks,
> put the local network name in file `/etc/nixos/.network`. The generator will load the file `config.<network>.yaml` and
> merge it with the common configuration `config.yaml`.
