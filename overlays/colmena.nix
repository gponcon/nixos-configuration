{ ... }:

{
  nixpkgs.overlays = [
    (_self: super: {
      colmena = super.callPackage (
        super.fetchFromGitHub {
          owner = "zhaofengli";
          repo = "colmena";
          rev = "main";
          sha256 = "0a8wilc4hw22lgx7c990vydci7s8wiyifzdc8mljl1l6yfln5fic";
        }
      );
    })
  ];
}
