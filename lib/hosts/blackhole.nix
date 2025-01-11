# Blackhole machine is used to build all usefull modules
# in the builder machine before applying on real hosts.
# WIP: autogeneration of blackhole host

{
  imports = [
    ./../../usr/common.nix
    ./../../usr/users
  ];

  darkone.host.laptop.enable = true;
  darkone.host.server.enable = true;
  darkone.host.portable.enable = true;

  darkone.user.advanced.enable = true;
  darkone.user.children.enable = true;
  darkone.user.teenager.enable = true;
  darkone.user.nix-admin.enable = true;

  system.stateVersion = "24.05";
}
