inputs@{ config, pkgs, lib ? pkgs.lib, ... }:

(lib.recursiveUpdate (import ../home.nix inputs) {
  home.username = "jacobranson";
  home.homeDirectory = "/home/jacobranson";

  programs.kitty = {
    enable = true;
    settings = {
      shell = "${config.home.homeDirectory}/.nix-profile/bin/zsh";
      confirm_os_window_close = 0;
    };
  };

  programs.zsh = {
    sessionVariables = {
      "SHELL" = "${config.home.homeDirectory}/.nix-profile/bin/zsh";
      "EDITOR" = "${config.home.homeDirectory}/.nix-profile/bin/hx";
    };
    shellAliases = {
      switch =
        "home-manager switch --flake ${config.xdg.configHome}/nix-system";
    };
  };
})
