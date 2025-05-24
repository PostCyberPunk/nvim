{
  description = "Using Lazyvim Coniguration in Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # neovim-nightly.url = "github:neovim/neovim?dir=contrib";
    # neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";
    evergarden-nvim = {
      url = "github:everviolet/nvim";
      flake = false;
    };
    # Plugins not available in nixpkgs
    hlchunk-nvim = {
      url = "github:postcyberpunk/hlchunk.nvim?ref=pcp-fix";
      flake = false;
    };
    cmake-tools-nvim = {
      url = "github:Civitasv/cmake-tools.nvim";
      flake = false;
    };
    cmake-gtest-nvim = {
      url = "github:hfn92/cmake-gtest.nvim";
      flake = false;
    };
    color-picker-nvim = {
      url = "github:ziontee113/color-picker.nvim";
      flake = false;
    };
    colorful-winsep-nvim = {
      url = "github:nvim-zh/colorful-winsep.nvim";
      flake = false;
    };
    univim-nvim = {
      url = "github:postcyberpunk/univim.nvim";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    mkPkg = system: let
      inherit system;
      pkgs = import nixpkgs {
        inherit system;
        #NOTE:Some AI plugin is marked as unfree
        config.allowUnfree = true;
        overlays =
          inputs.overlays or [
            (self: super: {
              pcp_nvim = {
                useXDG = false;
                extraArgs = [];
              };
            })
          ];
      };
      lib = pkgs.lib;
      nvim = import ./nix {inherit pkgs lib inputs;};
    in {
      default = nvim {};
      full = nvim {
        useXDG = true;
        extraArgs = ["dap" "cpp" "rust" "unity" "ai" "neorg" "extraTheme"];
      };
      extra = nvim pkgs.pcp_nvim;
    };
  in {
    packages = forAllSystems mkPkg;
    modules = import ./nix/module.nix;
  };
}
