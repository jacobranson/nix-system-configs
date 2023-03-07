inputs@{ config, pkgs, lib ? pkgs.lib, ... }:

(lib.recursiveUpdate (import ../../home.nix inputs) {
  home.username = "deck";
  home.homeDirectory = "/home/deck";
})
