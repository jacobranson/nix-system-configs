inputs@{ config, pkgs, lib ? pkgs.lib, ... }:

{
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.sessionVariables = rec {
    XDG_CACHE_HOME  = "${config.home.homeDirectory}/.cache";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_BIN_HOME    = "${config.home.homeDirectory}/.local/bin";
    XDG_DATA_HOME   = "${config.home.homeDirectory}/.local/share";
    XDG_DATA_DIRS   =
      "${config.home.homeDirectory}/.nix-profile/share:\${XDG_DATA_DIRS}";

    PATH = [
      "${config.home.homeDirectory}/.nix-profile/bin"
      "\${XDG_BIN_HOME}"
    ];
  };

  # Terminal shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh"; # relative to the user's home directory

    initExtra = ''
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
    '';

    history = {
      path = "\${ZDOTDIR}/zsh_history";
      ignoreDups = true;
    };

    zplug = {
      enable = true;
      zplugHome = "${config.xdg.configHome}/zsh/zplug";

      plugins = [
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "wfxr/forgit"; }
      ];
    };
  };

  # Terminal prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Terminal fuzzy finder
  programs.fzf = {
    enable = true;
  };

  # Version control
  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    userName = "Jacob Ranson";
    userEmail = "code@jacobranson.dev";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  # Alternative to `ls`
  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  # Alternative to `cat`
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  # Alternative to `top`
  programs.htop = {
    enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
