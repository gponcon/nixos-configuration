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
  programs.git = {
    enable = true;
    userName = "${user.name}";
    userEmail = "${user.email}";
    aliases = {
      amend = "!git add . && git commit --amend --no-edit";
      pf = "!git push --force";
    };
    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
