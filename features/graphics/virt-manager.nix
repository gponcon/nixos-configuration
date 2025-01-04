{ pkgs, hostname, ... }:

if hostname == "nlt" then
  {
    # Dependencies
    environment.systemPackages = with pkgs; [
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
    ];

    # Virt Manager module
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "gponcon" ];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  }
else
  { }
