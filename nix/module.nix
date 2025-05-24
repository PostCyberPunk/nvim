inputs: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (pkgs.stdenv.platform) system;
  pacakge = inputs.self.${system}.nvim;
  cfg = config.pcpNvim;
in {
  options.myNvimModule = {
    enable = mkEnableOption "Enable my custom nvim setup.";
    ominisharp = mkEnableOption "Enable ominisharp related plugins and runtime.";
    extraThemes = mkEnableOption "Extra colorschemes";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pacakge];
  };
}
