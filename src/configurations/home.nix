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

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  programs.nix-index.enable = true;
  programs.direnv.enable = true;
  programs.nushell.enable = true;
  programs.starship.enable = true;
  programs.zellij.enable = true;
  programs.zoxide.enable = true;
  programs.helix.enable = true;
  programs.gitui.enable = true;

  home.packages = with pkgs; [
    comma rnix-lsp
    coreutils findutils gnugrep gnused gawk
    perl less which wget curlFull dig
    httpie jq grex eva skim
    fd sd ripgrep procs bottom
    du-dust rargs neofetch
    navi tealdeer hyperfine bandwhich hexyl 
  ] ++ (lib.lists.optionals (stdenv.system == "x86_64-linux") [
    nixgl.nixGLIntel nixgl.nixVulkanIntel
  ]);
}
