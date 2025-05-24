inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.pcp-nvim;
  package = inputs.self.packages.${system}.nvim {inherit (cfg) useXDG extraPlugins;};
in {
  options.pcp-nvim = with types; {
    enable = mkEnableOption "Enable my custom nvim setup.";
    useXDG = mkEnableOption "Enable my custom nvim setup.";
    extraPlugins = mkOption {
      type = listOf str;
      description = "extra plugin sets";
      default = [];
      example = ["dap" "cpp" "rust" "unity" "java" "ai" "neorg" "extraTheme"];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      package
    ];
  };
}
