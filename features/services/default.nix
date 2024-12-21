{
  imports = [
    ./audio.nix
    ./printing.nix
    #./forgejo.nix
    ./packages.nix
    ./ssh.nix
    ./httpd.nix
    ./virt.nix
  ];

  programs.git.enable = true;
}