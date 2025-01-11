{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Guillaume Ponçon";
    userEmail = "gponcon@gmail.com";
    signing = {
      key = "F692EC0E0A6B911B1EE2D62230C39F3364E0D66F";
      signByDefault = false;
    };
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
    #signing.key = "B9B56B3937952BC41ABA3570A6A45734C77AC5F2";
    #commit = {
    #  gpgsign = true;
    #};
    #core = {
    #  sshCommand = "ssh -i ~/.ssh/id_ed25519_darkone_yt";
    #};
  };
}
