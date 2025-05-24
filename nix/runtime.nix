{
  pkgs,
  extraPlugins,
  ...
}: let
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
    paths = with pkgs;
      [
        # LazyVim dependencies
        lazygit
        ripgrep
        fd
        # luarocks

        # LSP's
        # (make-lazy "nil" "nil")
        (make-lazy "nixd" "nixd")
        (make-lazy "marksman" "marksman")
        (make-lazy "yaml-language-server" "yaml-language-server")
        (make-lazy "lua-language-server" "lua-language-server")
        (make-lazy "bash-language-server" "bash-language-server")
        (make-lazy "nodePackages.prettier" "prettier")

        # Formatters
        (make-lazy "stylua" "stylua")
        (make-lazy "alejandra" "alejandra")
        (make-lazy "jq" "jq")
        (make-lazy "shfmt" "shfmt")

        # Linters
        (make-lazy "markdownlint-cli" "markdownlint-cli")
        (make-lazy "shellcheck" "shellcheck")
      ]
      ++ lib.optionals (lib.elem "dap" extraPlugins) [
        # Debuggers
        codelldb
      ]
      ++ lib.optionals (lib.elem "cpp" extraPlugins) [
        clangd
        cmakelint
        (make-lazy "neocmakelsp" "neocmakelsp")
        (make-lazy "cmake-format" "cmake-format")
        # Bundle also cmake
        (make-lazy "cmake" "cmake")
      ]
      ++ lib.optionals (lib.elem "rust" extraPlugins) [
        (make-lazy "taplo" "taplo")
        (make-lazy "rust-analyzer" "rust-analyzer")
      ]
      ++ lib.optionals (lib.elem "unity" extraPlugins) [
        #csharp
        dotnet-sdk_9
        omnisharp-roslyn
        vscode-extensions.visualstudiotoolsforunity.vstuc
      ]
      ++ lib.optionals (lib.elem "java" extraPlugins) [
        # (make-lazy "jdt-language-server" "jdtls")
        jdt-language-server
      ];
  }
