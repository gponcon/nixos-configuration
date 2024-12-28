{
  # Installe les paquetages dans /etc/profiles plutôt que 
  # dans $HOME/.nix-profile (comportement par défaut)
  home-manager.useUserPackages = true;

  # On utilise l'instance pkgs globale avec les options nixpkgs
  # au niveau système, plutôt qu'une instance privée, qu'on
  # pourrait configurer dans home-manager.users.<name>.nixpkgs
  home-manager.useGlobalPkgs = true;
}
