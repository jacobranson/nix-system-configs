inputs@{ config, pkgs, lib ? pkgs.lib, ... }:

(lib.recursiveUpdate (import ../home.nix inputs) {
  home.username = "jacobranson";
  home.homeDirectory = "/Users/jacobranson";

  programs.zsh = {
    initExtraFirst = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    sessionVariables = {
      "SHELL" = "/etc/profiles/per-user/jacobranson/bin/zsh";
      "EDITOR" = "/etc/profiles/per-user/jacobranson/bin/hx";
    };
    shellAliases = {
      switch =
        "darwin-rebuild switch --flake ${config.xdg.configHome}/nix-system";
    };
  };
})
