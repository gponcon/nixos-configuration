# This file contains a list of manually declared hosts
# for local network and is read by the root flake file.
# Will be replace by config.toml

[
  {
    hostname = "nlt"; # static or generated host
    users = [ "darkone" ]; # static or generated users

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
    users = [ "darkone" ];
    deployment = {
      tags = [
        "test"
        "admin"
      ];
    };
  }
  {
    hostname = "test2";
    users = [ "darkone" ];
    deployment = {
      tags = [
        "test"
      ];
      targetHost = "ndf-start-iso";
    };
  }
]
