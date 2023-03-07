inputs@{ config, pkgs, lib ? pkgs.lib, ... }:

(lib.recursiveUpdate (import ../configuration.nix inputs) {
  programs.zsh.enable = true; # Create /etc/zshrc that loads the nix-darwin env
  services.nix-daemon.enable = true; # Allow multi-user Nix to work without sudo
  nix.configureBuildUsers = true; # add additional users for nixpkgs builds
  nix.settings = {
    experimental-features = [ "nix-command flakes" ]; # enable new Nix workflow
    extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ]; # enable macOS pkgs
    trusted-users = [ "@admin" ]; # allow root users to manage Nix
    auto-optimise-store = true; # deduplicate and optimize Nix store
  };

  users.users.jacobranson = {
    name = "jacobranson";
    home = "/Users/jacobranson";
  };

  homebrew = {
    enable = true; # allow nix to manage homebrew (this does not install it)
    onActivation.autoUpdate = true; # pull in the latest repo changes on switch
    onActivation.upgrade = true; # upgrade packages on switch
    taps = [ # additional repos
      "homebrew/cask-drivers"
    ];
    casks = [ # macOS applications
      # Fix macOS annoyances
      "rectangle"
      "hiddenbar"
      "keepingyouawake"
      "mouse-fix"
      "notunes"

      # Native macOS essentials
      "orion"
      "codeedit"
      "rapidapi"
      "iterm2"
      "utm"
      "iina"

      # Non-native essentials
      "bitwarden"
      "element"
      "signal"
      "obsidian"
      "visual-studio-code"
      "logi-options-plus"
      "nextcloud"
    ];
  };

  environment.systemPackages = with pkgs; []; # Additional global Nix packages

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
  ];

  # macOS System Settings
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.finder.FXDefaultSearchScope = "SCcf";
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.Dragging = true;
  system.defaults.trackpad.TrackpadRightClick = true;
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
})
