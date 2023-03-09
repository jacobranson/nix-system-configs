# macOS Onboarding Guide

This guide details the necessary steps to configuring an Apple Silicon macOS
system with the following:

- `nix`
- `nix-darwin`
- `home-manager`

## Preface

It is recommended to start from a fresh macOS install.

## Initial Setup

Make sure your device is up to date in the System Settings app. Make sure you
set a device name to something you like on the "General, About" panel. This name
will be used in your Nix configuration to uniquely identify this device.

## Add User to `wheel` Group

```bash
$ sudo dscl . append /Groups/wheel GroupMembership $USER
```

## Install Homebrew

Run the following commands in the Terminal app to install Homebrew. This will
also prompt you to install the `xcode-select` tools, as well.

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
$ eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Install Nix

Run the following commands in the Terminal app to install Nix.

```bash
$ curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install macos
$ . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

## Install Nix Darwin

Run the following commands in the Terminal app to install Nix Darwin.

```bash
$ . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
$ sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.orig
$ nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
$ ./result/bin/darwin-installer
```

### Prompt Responses for Nix Darwin

```
Would you like to edit the default configuration.nix before starting? [y/n] n
Would you like to manage <darwin> with nix-channel? [y/n] y
Would you like to load darwin configuration in /etc/bashrc? [y/n] y
Would you like to load darwin configuration in /etc/zshrc? [y/n] y
Would you like to create /run? [y/n] y
```

```bash
$ sudo reboot
$ ./result/bin/darwin-installer
$ exit
```

## Configure Git

You will also need to configure at least the following basic git configuration.
Replace the below name and email address with your own.

```bash
$ git config --global init.defaultBranch main
$ git config --global user.name "John Doe"
$ git config --global user.email "johndoe@example.com"
$ ssh-keygen -t ed25519 -C "johndoe@example.com"
$ cat ~/.ssh/id_ed25519.pub | pbcopy
```

Paste the public key into your GitHub account SSH keys.

## Create Nix Git Repository

```bash
$ mkdir -p ~/.config/nix-system
$ cd ~/.config/nix-system
$ git clone <ssh:url> .
```

## Update Nix Darwin

```bash
$ sudo mv /etc/zshenv /etc/zshenv.orig
$ darwin-rebuild switch --flake ~/.config/nix-system
```

## Cleanup

The following files are no longer needed. Use the first command to verify the
files you are about to remove, then run the second command to actually remove
them.

```bash
$ ls -la /etc/**/*.orig
$ sudo rm /etc/**/*.orig
$ rm ~/.gitconfig
$ rm -rf ~/result
```

## Build Nix Index

Populate the local database of `nixpkgs` for tools like `comma`.

```bash
$ nix-index
```
