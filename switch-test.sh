#!/bin/sh

# TMP

nixos-rebuild switch --flake .#test --target-host root@test
