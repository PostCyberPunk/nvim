{pkgs, ...}: let
  # codelldb executable is not exported by default
  codelldb = pkgs.writeShellScriptBin "codelldb" ''
    nix shell --impure --expr 'with import (builtins.getFlake "nixpkgs") {}; writeShellScriptBin "codelldb" "''${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb $@"' --command codelldb "$@"
  '';

  # cmake-lint is used as cmakelint
  cmakelint = pkgs.writeShellScriptBin "cmakelint" ''
    nix shell nixpkgs#cmake-format --command cmake-lint "$@"
  '';

  clangd = pkgs.writeShellScriptBin "clangd" ''
    if [ -f /opt/vector-clang-tidy/bin/clangd ]; then
      /opt/vector-clang-tidy/bin/clangd "$@"
    else
      nix shell nixpkgs#clang-tools_16 --command clangd "$@"
    fi
  '';

  make-lazy = pkg: bin:
    pkgs.writeShellScriptBin "${bin}" ''
      nix shell nixpkgs#${pkg} --command ${bin} "$@"
    '';
  # Link together all runtime dependencies into one derivation
in
  pkgs.symlinkJoin {
    name = "lazyvim-nix-runtime";
    paths = with pkgs; [
      # LazyVim dependencies
      lazygit
      ripgrep
      fd
      luarocks

      # LSP's
      #(make-lazy "clang-tools_16" "clangd")
      clangd
      # (make-lazy "nil" "nil")
      (make-lazy "nixd" "nixd")
      (make-lazy "taplo" "taplo")
      (make-lazy "rust-analyzer" "rust-analyzer")
      (make-lazy "marksman" "marksman")
      (make-lazy "neocmakelsp" "neocmakelsp")
      (make-lazy "yaml-language-server" "yaml-language-server")
      (make-lazy "lua-language-server" "lua-language-server")
      (make-lazy "bash-language-server" "bash-language-server")
      (make-lazy "nodePackages.prettier" "prettier")

      # Debuggers
      codelldb

      # Formatters
      (make-lazy "stylua" "stylua")
      (make-lazy "alejandra" "alejandra")
      (make-lazy "jq" "jq")
      (make-lazy "shfmt" "shfmt")

      # Linters
      (make-lazy "markdownlint-cli" "markdownlint-cli")
      (make-lazy "cmake-format" "cmake-format")
      cmakelint

      # Bundle also cmake
      (make-lazy "cmake" "cmake")
    ];
  }
