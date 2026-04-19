{
  description = "alexschoenwitz nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    nix-colors.url = "github:Misterio77/nix-colors";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      darwin,
      fenix,
      home-manager,
      mac-app-util,
      nix-colors,
      nix-index-database,
      nixpkgs,
      nixvim,
      ...
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          system = system;
        }
      );

      user = import ./lib/user.nix;

      dotnetBinaryOverlay = _final: prev: {
        dotnetCorePackages = prev.dotnetCorePackages // {
          sdk_8_0 = prev.dotnetCorePackages.sdk_8_0-bin;
          runtime_8_0 = prev.dotnetCorePackages.runtime_8_0-bin;
        };
      };

      commonOverlays = [
        dotnetBinaryOverlay
        fenix.overlays.default
      ];

      homeManagerConfig = userOverride: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.sharedModules = [
          mac-app-util.homeManagerModules.default
          nixvim.homeModules.nixvim
          nix-index-database.homeModules.default
        ];
        home-manager.extraSpecialArgs = {
          user = userOverride;
          inherit nix-colors;
        };
      };
    in
    {
      darwinConfigurations = {
        home = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            user = user;
          };
          modules = [
            ./machines/home
            { nixpkgs.overlays = commonOverlays; }
            home-manager.darwinModules.home-manager
            (homeManagerConfig user)
          ];
        };
        work = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            user = user;
          };
          modules = [
            ./machines/work
            { nixpkgs.overlays = commonOverlays; }
            home-manager.darwinModules.home-manager
            (homeManagerConfig user)
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt);

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          format-check = pkgs.runCommand "format-check" { buildInputs = [ pkgs.nixfmt ]; } ''
            cd ${./.}
            nixfmt --check .
            touch $out
          '';
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
          dot-clean = pkgs.writeScriptBin "dot-clean" ''
            sudo HOME=/var/root nix-env --delete-generations +5 --profile /nix/var/nix/profiles/system
            sudo nix-collect-garbage -d --delete-older-than 30d
          '';
          dot-apply = pkgs.writeScriptBin "dot-apply" ''
            nix build "./#darwinConfigurations.$(hostname | cut -f1 -d'.').system"
            sudo ./result/sw/bin/darwin-rebuild switch --flake .
          '';
          dot-check = pkgs.writeScriptBin "dot-check" ''
            nix flake check
            ${pkgs.deadnix}/bin/deadnix --fail ${./.}
            nix eval --json "./#darwinConfigurations.$(hostname | cut -f1 -d'.').config.system.stateVersion" > /dev/null
          '';
          dot-sync = pkgs.writeScriptBin "dot-sync" ''
            git pull --rebase origin main
            nix flake update
            ${dot-clean}/bin/dot-clean
            ${dot-apply}/bin/dot-apply
          '';
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs = [
              dot-clean
              dot-apply
              dot-check
              dot-sync
            ];
          };

        }
      );
    };
}
