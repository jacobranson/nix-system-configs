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

  programs.nushell = {
    enable = true;
  };

  # Terminal prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
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

  home.packages = with pkgs; [
    # nix
    comma direnv
    # basic utilities
    coreutils findutils gnugrep gnused gawk
    perl less which man wget curlFull
    ## RUST
    # workflow
    zellij hunter zoxide gitui
    # basic utils
    (uutils-coreutils.override { prefix = ""; }) exa bat fd sd
    ripgrep frawk procs bottom dust dog rargs hck freshfetch
    # other utils
    gitoxide jql cb grex xh skim eva cpc just rnr
    navi tealdeer hyperfine bandwhich hexyl hexyl 
  ] ++ (lib.lists.optionals (stdenv.system == "x86_64-linux") [
    nixgl.nixGLIntel nixgl.nixVulkanIntel
  ]);
}
