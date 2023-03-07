inputs@{ pkgs, lib ? pkgs.lib, darwin, home-manager, ... }:

{
  "Jacobs-MacBook-Air" = import ./systems/Jacobs-MacBook-Air {
    inherit (inputs) pkgs lib darwin home-manager;
  };

  # Other macOS devices...
}
