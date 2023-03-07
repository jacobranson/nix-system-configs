inputs@{ pkgs, lib ? pkgs.lib, darwin, home-manager, ... }:

darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    ./configuration.nix
    home-manager.darwinModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.jacobranson = import ./home.nix;
      };
    }
  ];
}
