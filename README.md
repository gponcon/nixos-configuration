# Darkone NixOS Framework

Une configuration NixOS destinée à devenir un framework pour la création et la gestion d'un réseau multi-host et multi-utilisateur avec NixOS.

> [!WARNING]  
> Ce projet est en cours de développement, il est utilisable en l'état, mais incomplet. En outre, il comporte des éléments de personnalisation issus de mes configurations, qui seront retirés de la version utilisable.

Les configurations NixOS sont parfois un peu complexes à mettre en place. Ce framework simplifie les choses grâce à&nbsp;:

- Une structure cohérente et modulaire.
- Des outils préconfigurés et fonctionnels.
- Une organisation pensée pour la scalabilité.

## Fonctionnalités

- **Déploiements multi-hosts** et multi-utilisateurs avec [colmena](https://github.com/zhaofengli/colmena).
- **Configurations types** pour serveurs, containers et machines de travail.
- **Modules complets** et 100% fonctionnels avec un simple `.enable = true`.
- **Architecture extensible** et personnalisable.
- **Gestion des dotfiles** de chaque utilisateur avec [home manager](https://github.com/nix-community/home-manager).
- **[Homepage](https://github.com/gethomepage/homepage) automatique** en fonction des services activés.
- **Configuration transversale** pour assurer la cohérence du réseau.

## Organisation

```
flake.nix             <-- Main flake
Makefile              <-- Nix sources management
modules/
  default.nix         <-- Auto-generated default (by Makefile)
  system/             <-- System / Hardware configurations
    core.nix          <-- Core features (activated by default)
    i18n.nix          <-- Lang / Region settings
    doc.nix           <-- Technical doc
  console/(...)       <-- CLI applications
  graphic/(...)       <-- X applications
  service/(...)       <-- Daemons
  admin/              <-- Nix administration settings
    nix.nix           <-- Nix tools
    identity.nix      <-- Identities and groups (profiles) with LDAP
  host/               <-- Host profiles (macro-modules)
    minimal.nix
    server/
      gateway.nix
      backup.nix
      homelab.nix
      builder.nix
    desktop/
      office.nix
      administrator.nix
    container/
      docker.nix
      nix.nix
    vm/
      virtualbox.nix
      xen.nix
  user/               <-- User profiles
    common/
      home/(...)      <-- Common home modules
    admin/            <-- System Admin
      default.nix
      home/(...)
    developper/(...)  <-- Advanced user with development tools
    gamer/(...)       <-- Optimized environment for gamers
    regular/(...)     <-- Non-technical user
    beginner/(...)    <-- Easy environment
    kid/(...)         <-- Kids softwares and settings
users/                <-- Static users
  nix/                <-- User for node management
hosts/                <-- Static hosts
  darkone/            <-- Administrator host
```

## Exemples

> [!CAUTION]
> Ces exemples ne sont pas encore fonctionnels, mais ça arrive. Ces configurations et commandes pourront différer dans la future version stable du projet.

Configurer un poste bureautique complet se fera très simplement :

```nix
# hosts/patrick/default.nix
{
  darkone.host.desktop = {
    enable = true;
    hostname = "patrick";
    username = "patrick";
  };
}
```

Création du poste et mises à jour :

```sh
# Injection de la conf de patrick dans un poste physique
# sur lequel a été installé l'iso du framework
nixos-anywhere --flake '.#patrick' --target-host nix@<ip-du-poste>

# Mise à jour
colmena apply --on patrick switch

# Mise à jour de tous les desktops
colmena apply --on @desktop switch
```

Créer une passerelle se fera très simplement de cette manière :

```nix
# loc/hosts/server-gateway.nix
darkone.host.gateway = {
  enable = true;
  wan = {
    interface = "eth0";
    gateway = "192.168.0.1"; # optional
  };
  lan = {
    interfaces = [ "wlan0" "enu1u4" ]; # wlan must be an AP
    bridgeIp = "192.168.1.1";
    domain = "arthur.lan"; # optional (default is <hostname>.lan)
    dhcp = { # optional
      enable = true;
      range = "192.168.1.100,192.168.1.230,24h";
      hosts = [
        "e8:ff:1e:d0:44:82,192.168.1.2,darkone,infinite"
        "f0:1f:af:13:62:a5,192.168.1.3,laptop,infinite"
      ];
      extraOptions = [
        "option:ntp-server,191.168.1.1"
      ];
    };
    accessPoints = [
      wlan0 = {
        ssid = "Mon AP";
        passphrase = "Un password";
      };
    ];
  };
};
```

On peut déployer de 2 manières :

```sh
# Regular
nixos-rebuild switch --flake path:.#gateway --target-host admin@gateway --build-host gateway --fast --use-remote-sudo

# Colmena
colmena apply --on gateway switch
```

## Liste TODO

- [x] Architecture modulaire.
- [x] Déploiements avec Colmena.
- [x] Modules système de base (hardware, i18n, doc, network, performances).
- [x] Modules console de base (zsh, git, shell).
- [x] Modules graphic de base (gnome, jeux de paquetages).
- [x] Hosts préconfigurés : minimal, serveur, desktop, laptop.
- [x] Makefile pour checker et fixer les sources.
- [ ] Création de noeuds avec [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) + [disko](https://github.com/nix-community/disko) (wip).
- [ ] Homepage automatique en fonction des services activés (wip).
- [ ] Configuration transversale générale (wip).
- [ ] Chaîne CI / CD pour la gestion de ce développement (wip).
- [ ] Passerelle type (dhcp, dns, ap, firewall, adguard, AD).
- [ ] Postes types (bureautique, développeur, administrateur, enfant).
- [ ] Services pré-configurés pour serveurs (nextcloud, etc.).
- [ ] Gestion centralisée des utilisateurs avec [lldap](https://github.com/lldap/lldap).
- [ ] Builder d'[ISOs d'installation](https://github.com/nix-community/nixos-generators) pour les machines à intégrer.
- [ ] Refactoring des commentaires de code en anglais.
- [ ] Documentation FR et EN (wip).
- [ ] Intégration de [nixvim](https://nix-community.github.io/nixvim/).
- [ ] Gestion du secureboot avec [lanzaboote](https://github.com/nix-community/lanzaboote).
