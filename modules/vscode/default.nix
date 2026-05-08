{
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        # ── Extensions ────────────────────────────────────────────
        extensions = with pkgs.vscode-extensions; [
          # Vim
          vscodevim.vim

          # Theme
          jdinhlife.gruvbox

          # Bash
          mads-hartmann.bash-ide-vscode
          timonwong.shellcheck
          foxundermoon.shell-format

          # C#
          ms-dotnettools.csharp
          ms-dotnettools.csdevkit
          ms-dotnettools.vscode-dotnet-runtime

          # Dart / Flutter
          dart-code.dart-code
          dart-code.flutter

          # Go
          golang.go

          # Nix
          jnoortheen.nix-ide

          # Python
          ms-python.python
          charliermarsh.ruff

          # Rust
          rust-lang.rust-analyzer

          # Terraform
          hashicorp.terraform

          # TypeScript / JS
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode

          # Editor
          editorconfig.editorconfig
        ];

        # ── Settings ──────────────────────────────────────────────
        userSettings = {

          # ── Editor ──
          "editor.tabSize" = 4;
          "editor.insertSpaces" = true;
          "editor.lineNumbers" = "on";
          "editor.cursorSurroundingLines" = 5;
          "editor.renderLineHighlight" = "all";
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
          "editor.linkedEditing" = true;
          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.bracketPairs" = "active";
          "editor.wordWrap" = "off";

          # ── Search ──
          "search.smartCase" = true;

          # ── Terminal ──
          "terminal.integrated.fontFamily" = "Noto Sans Mono";

          # ── Theme ──
          "workbench.colorTheme" = "Gruvbox Dark Medium";
          "workbench.preferredDarkColorTheme" = "Gruvbox Dark Medium";
          "workbench.preferredLightColorTheme" = "Gruvbox Light Medium";
          "window.autoDetectColorScheme" = true;
          "workbench.startupEditor" = "none";

          # ── Files ──
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.autoSave" = "off";

          # ── Explorer ──
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;

          # ── Telemetry ──
          "telemetry.telemetryLevel" = "off";

          # ── Git ──
          "git.autofetch" = true;
          "git.confirmSync" = false;

          # ── Vim ──
          "vim.leader" = "<space>";
          "vim.hlsearch" = true;
          "vim.ignorecase" = true;
          "vim.smartcase" = true;
          "vim.useSystemClipboard" = true;
          "vim.useCtrlKeys" = true;
          "vim.highlightedyank.enable" = true;
          "vim.highlightedyank.duration" = 200;
          "vim.handleKeys" = {
            "<C-d>" = true;
            "<C-u>" = true;
            "<C-f>" = false;
            "<C-a>" = false;
            "<C-c>" = false;
            "<C-v>" = false;
            "<C-x>" = false;
            "<C-z>" = false;
            "<C-w>" = false;
          };

          "vim.normalModeKeyBindingsNonRecursive" = [
            # ── Explorer ──
            {
              before = [ "<leader>" "e" ];
              commands = [ "workbench.view.explorer" ];
            }

            # ── Quick Open ──
            {
              before = [ "<leader>" "<space>" ];
              commands = [ "workbench.action.quickOpen" ];
            }

            # ── Buffers / Open Editors ──
            {
              before = [ "<leader>" "," ];
              commands = [ "workbench.action.showAllEditorsByMostRecentlyUsed" ];
            }

            # ── Grep / Find in Files ──
            {
              before = [ "<leader>" "/" ];
              commands = [ "workbench.action.findInFiles" ];
            }

            # ── Command Palette ──
            {
              before = [ "<leader>" ":" ];
              commands = [ "workbench.action.showCommands" ];
            }

            # ── Diagnostics / Problems ──
            {
              before = [ "<leader>" "d" ];
              commands = [ "workbench.actions.view.problems" ];
            }

            # ── Find: files ──
            {
              before = [ "<leader>" "f" "f" ];
              commands = [ "workbench.action.quickOpen" ];
            }

            # ── Find: recent ──
            {
              before = [ "<leader>" "f" "r" ];
              commands = [ "workbench.action.openRecent" ];
            }

            # ── LSP: go to definition ──
            {
              before = [ "g" "d" ];
              commands = [ "editor.action.revealDefinition" ];
            }

            # ── LSP: go to declaration ──
            {
              before = [ "g" "D" ];
              commands = [ "editor.action.revealDeclaration" ];
            }

            # ── LSP: references ──
            {
              before = [ "g" "r" ];
              commands = [ "editor.action.goToReferences" ];
            }

            # ── LSP: go to implementation ──
            {
              before = [ "g" "I" ];
              commands = [ "editor.action.goToImplementation" ];
            }

            # ── LSP: go to type definition ──
            {
              before = [ "g" "y" ];
              commands = [ "editor.action.goToTypeDefinition" ];
            }

            # ── LSP: document symbols ──
            {
              before = [ "<leader>" "s" "s" ];
              commands = [ "workbench.action.gotoSymbol" ];
            }

            # ── LSP: workspace symbols ──
            {
              before = [ "<leader>" "s" "S" ];
              commands = [ "workbench.action.showAllSymbols" ];
            }

            # ── LSP: code action ──
            {
              before = [ "<leader>" "c" "a" ];
              commands = [ "editor.action.quickFix" ];
            }

            # ── LSP: rename ──
            {
              before = [ "<leader>" "c" "r" ];
              commands = [ "editor.action.rename" ];
            }

            # ── Splits ──
            {
              before = [ "<leader>" "u" ];
              commands = [ "workbench.action.splitEditorDown" ];
            }
            {
              before = [ "<leader>" "i" ];
              commands = [ "workbench.action.splitEditorRight" ];
            }

            # ── Pane navigation ──
            {
              before = [ "<C-h>" ];
              commands = [ "workbench.action.focusLeftGroup" ];
            }
            {
              before = [ "<C-j>" ];
              commands = [ "workbench.action.focusBelowGroup" ];
            }
            {
              before = [ "<C-k>" ];
              commands = [ "workbench.action.focusAboveGroup" ];
            }
            {
              before = [ "<C-l>" ];
              commands = [ "workbench.action.focusRightGroup" ];
            }

            # ── Git ──
            {
              before = [ "<leader>" "g" "b" ];
              commands = [ "git.checkout" ];
            }
            {
              before = [ "<leader>" "g" "B" ];
              commands = [ "git.blame.toggleInlineMessage" ];
            }
            {
              before = [ "<leader>" "g" "s" ];
              commands = [ "workbench.view.scm" ];
            }
            {
              before = [ "<leader>" "g" "d" ];
              commands = [ "git.openChange" ];
            }

            # ── Search: clear highlight ──
            {
              before = [ "<leader>" "s" "r" ];
              after = [ ":" "n" "o" "h" "l" "<CR>" ];
            }
          ];

          "vim.visualModeKeyBindingsNonRecursive" = [
            # ── Grep selection ──
            {
              before = [ "<leader>" "s" "w" ];
              commands = [ "workbench.action.findInFiles" ];
            }
          ];

          # ── Language: Nix ──
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {
            nixd = {
              formatting = {
                command = [ "nixfmt" ];
              };
            };
          };
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };

          # ── Language: Go ──
          "go.formatTool" = "gofumpt";
          "go.lintOnSave" = "workspace";
          "go.useLanguageServer" = true;
          "gopls" = {
            "formatting.gofumpt" = true;
          };
          "[go]" = {
            "editor.defaultFormatter" = "golang.go";
          };

          # ── Language: Python ──
          "ruff.organizeImports" = true;
          "[python]" = {
            "editor.defaultFormatter" = "charliermarsh.ruff";
          };

          # ── Language: Rust ──
          "rust-analyzer.check.command" = "clippy";
          "[rust]" = {
            "editor.defaultFormatter" = "rust-lang.rust-analyzer";
          };

          # ── Language: TypeScript / JS / Web ──
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[javascriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[html]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[css]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[json]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };

          # ── Language: C# ──
          "[csharp]" = {
            "editor.defaultFormatter" = "ms-dotnettools.csharp";
          };

          # ── Language: Dart ──
          "[dart]" = {
            "editor.defaultFormatter" = "Dart-Code.dart-code";
          };

          # ── Language: Terraform ──
          "terraform.languageServer.enable" = true;
          "[terraform]" = {
            "editor.defaultFormatter" = "hashicorp.terraform";
          };

          # ── Language: Bash ──
          "bashIde.shellcheckPath" = "${pkgs.shellcheck}/bin/shellcheck";
          "[shellscript]" = {
            "editor.defaultFormatter" = "foxundermoon.shell-format";
          };
        };
      };
    };
  };
}
