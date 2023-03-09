inputs@{ pkgs, lib ? pkgs.lib, home-manager, ... }:

{
  "deck@steamdeck" = import ./systems/deck@steamdeck {
    inherit (inputs) pkgs lib home-manager;
  };

  # Other non-NixOS Linux devices...
}
