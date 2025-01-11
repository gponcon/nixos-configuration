{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Guillaume Ponçon";
    userEmail = "gponcon@gmail.com";
    aliases = {
      amend = "!git add . && git commit --amend --no-edit && git push --force";
    };
    ignores = [
      "*~"
      "*.swp"
    ];
    #extraConfig = {};
    #userName = "Darkone Linux";
    #userEmail = "darkone@darkone.yt";
    #commit = {
    #  gpgsign = true;
    #};
    #core = {
    #  sshCommand = "ssh -i ~/.ssh/id_ed25519_darkone_yt";
    #};
  };
}
