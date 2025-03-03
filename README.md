# Dotfiles

Nix configuration for macOS using nix-darwin and home-manager.

## Features

- **nix-darwin**: Declarative macOS system configuration
- **home-manager**: User environment and dotfiles management
- **Neovim via nixvim**: Full IDE setup with LSP, treesitter, and language support
- **AeroSpace**: Tiling window manager with ALT-based shortcuts

## Quick Start

1. Install Nix:
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Clone this repo:
```bash
git clone https://github.com/yourusername/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
```

3. Set your hostname:
```bash
sudo scutil --set ComputerName "home"
sudo scutil --set LocalHostName "home"
sudo scutil --set HostName "home"
```

4. Apply configuration:
```bash
nix develop
dot-apply
```

## Development Commands

Enter the development shell:
```bash
nix develop
```

Available commands:
- `dot-apply` - Build and switch to configuration
- `dot-check` - Validate configuration
- `dot-sync` - Update, clean, and apply
- `dot-clean` - Garbage collect old generations

Format Nix files:
```bash
nix fmt
```

## Structure

```
flake.nix                      # Main entry point
lib/user.nix                   # User configuration
machines/
  shared/
    darwin.nix                 # macOS system settings
  home/default.nix             # Personal machine
  work/default.nix             # Work machine
modules/
  default-user.nix             # Shared user modules
  default-user-darwin.nix      # macOS-specific modules
  nixvim/                      # Neovim configuration
  lang/                        # Language toolchains
  */                           # App configurations
```

## Customization

### Machine-specific settings

Edit files in `machines/*/default.nix` to customize:
- Git email
- SSH keys
- Additional packages

### Add new packages

Edit `modules/pkgs.nix` and add to the appropriate list:
- `sharedPackages` - Common packages
- `darwinOnlyPackages` - macOS only

## Debugging

Enter Nix REPL:
```bash
nix repl --expr "builtins.getFlake \"$PWD\""
```

Show full error trace:
```bash
nix flake check --show-trace
```
