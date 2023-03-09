{
  description = "Jacob Ranson's Nix System Configurations";

  inputs = { # arguments to this flake

    # nixpkgs channels
    nixpkgs-stable-darwin.url = # for macOS systems; stable pkgs
      "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixos-stable.url = # for NixOS systems; stable pkgs
      "github:NixOS/nixpkgs/nixos-22.11";
    nixos-unstable.url = # for NixOS systems; unstable pkgs
      "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = # for other Linux systems; unstable pkgs
      "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    darwin = { # for macOS systems to have a NixOS-like configuration
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
    };

    home-manager-nixpkgs-stable-darwin = { # for macOS systems; stable pkgs
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
    };

    home-manager-nixos-stable = { # for NixOS systems; stable pkgs
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixos-stable";
    };

    home-manager-nixos-unstable = { # for NixOS systems; unstable pkgs
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    home-manager-nixpkgs-unstable = { # for other Linux systems; unstable pkgs
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixgl = { # for non-NixOS Linux systems to use graphical applications
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = inputs@{ # derivations produced by this flake
    self, darwin, home-manager-nixpkgs-unstable, nixgl, ...
  }: {

    darwinConfigurations = import ./src/configurations/darwin { # for macOS
      pkgs = inputs.nixpkgs-stable-darwin.legacyPackages.aarch64-darwin;
      darwin = inputs.darwin;
      home-manager = inputs.home-manager-nixpkgs-stable-darwin;
    };

    homeConfigurations = import ./src/configurations/home { # for non-NixOS
      pkgs =
        (inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.extend nixgl.overlay);
      home-manager = inputs.home-manager-nixpkgs-unstable;
    };

  };
}
