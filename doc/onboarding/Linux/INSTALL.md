# Non-NixOS Linux Onboarding Guide

This guide details the necessary steps to configuring a non-NixOS Linux
system with the following:

- `nix`
- `home-manager`

## Configure Git

You will also need to configure at least the following basic git configuration.
Replace the below name and email address with your own.

```bash
$ git config --global init.defaultBranch main
$ git config --global user.name "John Doe"
$ git config --global user.email "johndoe@example.com"
```

## Install Nix

```bash
$ sudo setenforce Permissive # only on systems with SELinux
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
$ . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

## Create Home Manager Git Repository

```bash
$ mkdir -p ~/.config/nix-system
$ cd ~/.config/nix-system
$ git clone <ssh:url> .
```

## Bootstrap

```bash
$ nix build --no-link ~/.config/nix-system#homeConfigurations.deck.activationPackage
$ "$(nix path-info ~/.config/nix-system#homeConfigurations.deck.activationPackage)"/activate
```

## Update Home Manager

```bash
$ home-manager switch --flake ~/.config/nix-system
```

## Cleanup

```bash
$ rm ~/.gitconfig
$ reboot
```

## Build Nix Index

Populate the local database of `nixpkgs` for tools like `comma`.

```bash
$ nix-index
```
