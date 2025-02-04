# This file is generated by 'just generate'
# from the configuration file usr/config.yaml
# --> DO NOT EDIT <--

[
  {
    hostname = "nlt";
    name = "Darkone Laptop";
    profile = "admin-laptop";
    groups = [ "admin" ];
    networks = [
      "default"
      "sn"
    ];
    users = [
      "darkone"
      "gponcon"
    ];
    colmena = {
      deployment = {
        tags = [
          "laptops"
          "admin"
          "group-admin"
          "user-darkone"
          "user-gponcon"
          "network-default"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "sn-network";
    name = "SN Network Gateway";
    profile = "sn-network";
    groups = [ "sn-admin" ];
    networks = [ "sn" ];
    users = [
      "nixos"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-sn-admin"
          "user-nixos"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "vbox-01";
    name = "Virtual 01";
    profile = "vbox";
    groups = [ ];
    networks = [ "default" ];
    users = [ "darkone" ];
    colmena = {
      deployment = {
        tags = [
          "user-darkone"
          "network-default"
        ];
      };
    };
  }
  {
    hostname = "vbox-02";
    name = "Virtual 02";
    profile = "vbox";
    groups = [ ];
    networks = [ "default" ];
    users = [ "darkone" ];
    colmena = {
      deployment = {
        tags = [
          "user-darkone"
          "network-default"
        ];
      };
    };
  }
  {
    hostname = "vbox-03";
    name = "Virtual 03";
    profile = "vbox";
    groups = [ ];
    networks = [ "default" ];
    users = [ "darkone" ];
    colmena = {
      deployment = {
        tags = [
          "user-darkone"
          "network-default"
        ];
      };
    };
  }
  {
    hostname = "SN-20-01";
    name = "pc1";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-02";
    name = "pc2";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-03";
    name = "pc3";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-04";
    name = "pc4";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-05";
    name = "pc5";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-06";
    name = "pc6";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-07";
    name = "pc7";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
  {
    hostname = "SN-20-08";
    name = "pc8";
    profile = "sn-pc";
    groups = [
      "2mtne"
      "1ciel"
      "tsn"
      "sn"
    ];
    networks = [ "sn" ];
    users = [
      "diego"
      "mathieu"
      "brice"
      "nolann"
      "baptiste"
      "evan"
      "tiesto"
      "titouan"
      "kilic"
      "mathys"
      "julien"
      "esteban"
      "ethan"
      "nathael"
      "gponcon"
      "tserveau"
    ];
    colmena = {
      deployment = {
        tags = [
          "group-2mtne"
          "group-1ciel"
          "group-tsn"
          "group-sn"
          "user-diego"
          "user-mathieu"
          "user-brice"
          "user-nolann"
          "user-baptiste"
          "user-evan"
          "user-tiesto"
          "user-titouan"
          "user-kilic"
          "user-mathys"
          "user-julien"
          "user-esteban"
          "user-ethan"
          "user-nathael"
          "user-gponcon"
          "user-tserveau"
          "network-sn"
        ];
      };
    };
  }
]
