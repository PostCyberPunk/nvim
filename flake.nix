{
  description = "Using Lazyvim Coniguration in Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    # neovim-nightly.url = "github:neovim/neovim?dir=contrib";
    # neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

    # Plugins not available in nixpkgs
    cmake-tools-nvim = { url = "github:Civitasv/cmake-tools.nvim"; flake = false; };
    cmake-gtest-nvim = { url = "github:hfn92/cmake-gtest.nvim"; flake = false; };
    color-picker-nvim = { url = "github:ziontee113/color-picker.nvim"; flake = false; };
    colorful-winsep-nvim = { url = "github:nvim-zh/colorful-winsep.nvim"; flake = false; };
  };

  outputs = { self, nixpkgs, flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { pkgs, lib, system, ... }:
        let
          # Derivation containing all plugins
          pluginPath = import ./plugins.nix { inherit pkgs lib inputs; };

          # Derivation containing all runtime dependencies
          runtimePath = import ./runtime.nix { inherit pkgs; };

          # Link together all treesitter grammars into single derivation
          treesitterPath = pkgs.symlinkJoin {
            name = "lazyvim-nix-treesitter-parsers";
            paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
          };

          # Use nightly neovim only ;)
          # neovimNightly = inputs.neovim-nightly.packages.${system}.default;
          # Wrap neovim with custom init and plugins
          neovimWrapped = pkgs.wrapNeovim pkgs.neovim-unwrapped {
            configure = {
              customRC = /* vim */ ''
                " Populate paths to neovim
                let g:config_path = "${./.}"
                let g:plugin_path = "${pluginPath}"
                let g:runtime_path = "${runtimePath}"
                let g:treesitter_path = "${treesitterPath}"
                let g:isnix = 1
                " Begin initialization
                source ${./nixinit.lua}
              '';
              packages.all.start = [ pkgs.vimPlugins.lazy-nvim ];
            };
          };
        in
        {
          packages = rec {
            # Wrap neovim again to make runtime dependencies available
            nvim = pkgs.writeShellApplication {
              name = "nvim";
              runtimeInputs = [ runtimePath ];
              text = ''${neovimWrapped}/bin/nvim "$@"'';
            };
            default = nvim;
          };
        };
    };
}
