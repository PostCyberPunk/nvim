{
  pkgs,
  lib,
  inputs,
}: {
  useXDG ? false,
  extraArgs ? [],
}: let
  treesitterPath = pkgs.symlinkJoin {
    name = "lazyvim-nix-treesitter-parsers";
    paths =
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };

  pluginPath = import ./plugins.nix {inherit pkgs lib inputs extraArgs;};
  runtimePath = import ./runtime.nix {inherit pkgs extraArgs;};

  _extraArgs = lib.concatStringsSep "," extraArgs;
  customRC = lib.concatStrings (builtins.filter (x: x != null) [
    (
      if useXDG
      then ""
      else ''        let g:config_path = "${../.}"
      ''
    )
    ''
      let g:pcp_extra = "${_extraArgs}"
      let g:plugin_path = "${pluginPath}"
      let g:runtime_path = "${runtimePath}"
      let g:treesitter_path = "${treesitterPath}"
      let g:isnix = 1
      source ${../init.lua}
    ''
  ]);
  neovimWrapped = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    configure = {
      inherit customRC;
      packages.all.start = [pkgs.vimPlugins.lazy-nvim];
    };
    extraLuaPackages = ps:
      with ps;
      #HACK: extra
        lib.optionals (lib.elem "neorg" extraArgs)
        [lua-utils-nvim pathlib-nvim];
  };
in
  pkgs.writeShellApplication {
    name = "nvim";
    runtimeInputs = [runtimePath];
    #HACK: extra
    runtimeEnv = lib.mkIf (lib.elem "unity" extraArgs) {OMNISHARP_PATH = "${pkgs.omnisharp-roslyn}/lib/omnisharp-roslyn/OmniSharp.dll";};
    text = ''${neovimWrapped}/bin/nvim "$@"'';
  }
