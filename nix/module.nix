inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.programs.pcp-nvim;
  package = inputs.self.packages.${system}.nvim;
in {
  options.programs.pcp-nvim = with types; {
    enable = mkEnableOption "Enable my custom nvim setup.";
    useXDG = mkEnableOption "Enable my custom nvim setup.";
    extraPlugins = mkOption {
      type = listOf str;
      description = "extra plugin sets";
      default = [];
      example = ["dap" "cpp" "rust" "unity" "java" "ai" "neorg" "extraTheme"];
    };
    # from nixpkgs
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        When enabled, installs neovim and configures neovim to be the default editor
        using the EDITOR environment variable.
      '';
    };
    viAlias = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Symlink {command}`vi` to {command}`nvim` binary.
      '';
    };
    vimAlias = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Symlink {command}`vim` to {command}`nvim` binary.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 900 "nvim");
    environment.systemPackages = [
      (package {inherit (cfg) useXDG extraPlugins vimAlias viAlias;})
    ];
  };
}
