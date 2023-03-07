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
      "PAGER" = "/etc/profiles/per-user/jacobranson/bin/moar";
      "EDITOR" = "/etc/profiles/per-user/jacobranson/bin/nvim";
    };
    shellAliases = {
      switch =
        "darwin-rebuild switch --flake ${config.xdg.configHome}/nix-system";
    };
  };

  home.packages = with pkgs; [
    comma
    coreutils
    findutils
    gnugrep
    gnused
    gawk
    man
    which
    perl
    fd
    silver-searcher
    ripgrep
    moar
    neofetch
  ];
})
