inputs@{ config, pkgs, lib ? pkgs.lib, ... }:

(lib.recursiveUpdate (import ../home.nix inputs) {
  home.username = "jacobranson";
  home.homeDirectory = "/home/jacobranson";

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
    };
  };

  programs.zsh = {
    sessionVariables = {
      "SHELL" = "${config.home.homeDirectory}/.nix-profile/bin/zsh";
      "PAGER" = "${config.home.homeDirectory}/.nix-profile/bin/moar";
      "EDITOR" = "${config.home.homeDirectory}/.nix-profile/bin/nvim";
    };
    shellAliases = {
      switch =
        "home-manager switch --flake ${config.xdg.configHome}/nix-system";
    };
  };

  # Allows packages installed via Nix to integrate with the desktop environment
  xsession.enable = true;

  home.packages = with pkgs; [
    nixgl.nixGLIntel
    nixgl.nixVulkanIntel
    comma
    coreutils
    findutils
    gnugrep
    gnused
    gawk
    man
    which
    perl
    comma
    fd
    silver-searcher
    ripgrep
    moar
    neofetch
  ];
})
