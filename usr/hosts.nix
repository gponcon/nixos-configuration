# This file contains a list of manually declared hosts
# for local network and is read by the root flake file.

[
  {
    hostname = "nlt"; # static or generated host
    users = [ "gponcon" ]; # static or generated users

    # the "deployment" section of colmena
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
    users = [ "gponcon" ];
    deployment = {
      tags = [
        "test"
        "admin"
      ];
    };
  }
]
