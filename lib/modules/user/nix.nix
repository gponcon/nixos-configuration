# Special nix user for Darkone Network maintenance

{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.user;
in
{
  options = {
    darkone.user.isNode = lib.mkEnableOption "Darkone Network node";
  };

  config = lib.mkIf cfg.isNode {

    users.users.nix = {
      isNormalUser = true;
      description = "Nix Maintenance User";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.bash;
      packages = with pkgs; [ vim ];

      # https://systemd.io/UIDS-GIDS/
      uid = 65000;

      # Push public key to the node to manage it
      openssh.authorizedKeys.keyFiles = [ ./../../../var/security/ssh/id_ed25519_nix.pub ];
    };
  };
}
