# The usr directory

This directory contains all files specific to the local network(s) (host and user profiles, machines, configuration, add-ons, etc.).

> [!NOTE]
> This is where you can modify files.

- **config.yaml:** the main configuration file
- **homes:** additional or overloaded user profiles
- **modules:** additional or completed modules + host profiles
- **machines:** machine-specific configurations (hardware, etc.)
- **secrets:** your keys and passwords (sops)

> [!TIP]
> **Multiple network declaration:**
> 
> The `config.yaml` contains a networks, hosts and users declarations. To manage several networks, follow the comments
> in the configuration file.
