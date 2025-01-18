{
  config,
  host,
  lib,
  ...
}:
let

  # Extraction of current user from host configuration
  user = lib.lists.findFirst (user: user.login == "${config.home.username}") {
    name = "nobody";
  } host.users;
in
{
  programs.zsh = {
    enable = true;
      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./zsh;
          file = "p10k.zsh";
        }
      ];
  };
}
