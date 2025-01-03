{
  # Pages de manuel
  documentation = {
    enable = true;
    doc.enable = false;
    dev.enable = false;
    info.enable = false;
    nixos.enable = true;

    man = {
      enable = true;
      man-db.enable = false;
      mandoc.enable = true;
      generateCaches = true;
    };
  };
}
