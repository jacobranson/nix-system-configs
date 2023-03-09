inputs@{ pkgs, lib ? pkgs.lib, home-manager, ... }:

{
  deck = import ./systems/deck-steamdeck {
    inherit (inputs) pkgs lib home-manager;
  };

  # Other non-NixOS Linux devices...
}
