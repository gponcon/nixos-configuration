# This file is generated by 'just generate'
# DO NOT EDIT

[
  {
    hostname = "nlt"; # static or generated host
    users = [ "darkone" ]; # static or generated users
    deployment = {
      tags = [
        "desktop"
        "admin"
        "local"
      ];
      allowLocalDeployment = true;
    };
  }
  {
    hostname = "test";
    users = [ "darkone" ];
    deployment = {
      tags = [
        "test"
        "admin"
      ];
    };
  }
]
