inputs@{ pkgs, lib ? pkgs.lib, home-manager, ... }:

home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = [ ./home.nix ];
}
