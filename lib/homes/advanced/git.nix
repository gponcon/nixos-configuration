{ user, ... }:
{
  programs.git = {
    enable = true;
    userName = "${user.name}";
    userEmail = "${user.email}";
    aliases = {
      amend = "!git add . && git commit --amend --no-edit && git push --force";
    };
    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
