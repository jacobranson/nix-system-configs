# Nix Concepts

## Nixpkgs

The [NixOS/nixpkgs](https://github.com/NixOS/nixpkgs) repository is a monorepo
of all derivations offered by Nix. It offers a few branches, detailed below.

### `master`

The `master` branch is the upstream source of truth. It contains the bleeding-
edge updates to `nixpkgs` as they are merged from Nix contributors. As such, it
is not recommended to use the master branch in your configuration. This branch
contains derivations for both Linux *and* macOS.

### `nixpkgs-unstable`

The `nixpkgs-unstable` branch is updated with all changes made to the `master`
branch that pass an automated build/test process. Like `master`, this branch
contains derivations for both Linux *and* macOS.

### `nixos-unstable`

The `nixos-unstable` branch is also updated from the `master` branch, but only
contains derivations made for Linux specifically. It has a separate automated
build/test process.

### `nixpkgs-22.11-darwin`

The `nixpkgs-22.11-darwin` branch is updated from the `release-22.11` branch,
and contains stable derivations specifically for macOS.

### `nixos-22.11`

The `nixos-22.11` branch is updated from the `release-22.11` branch,
and contains stable derivations specifically for NixOS.

### Unstable Branches Diagram

```mermaid
flowchart TD
  master -->|After passing macOS & Linux CI build| nixpkgs-unstable
  master -->|After passing Linux CI build| nixos-unstable

  subgraph Linux & macOS Derivations
    master([master])
    nixpkgs-unstable([nixpkgs-unstable])
  end

  subgraph Linux Derivations Only
    nixos-unstable([nixos-unstable])
  end
```

### Stable Branches Diagram

```mermaid
flowchart TD
  release-22.11 -->|After passing macOS & Linux CI build| nixpkgs-22.11-darwin
  release-22.11 -->|After passing Linux CI build| nixos-22.11

  subgraph Linux & macOS Derivations
    release-22.11([release-22.11])
    nixpkgs-22.11-darwin([nixpkgs-22.11-darwin])
  end

  subgraph Linux Derivations Only
    nixos-22.11([nixos-22.11])
  end
```
