{
  pkgs,
  inputs,
  lib,
  extraPlugins,
  ...
}: let
  # Build plugins from github
  cmake-tools-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-tools.nvim";
    src = inputs.cmake-tools-nvim;
    doCheck = false;
  };
  cmake-gtest-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-gtest.nvim";
    src = inputs.cmake-gtest-nvim;
    doCheck = false;
  };
  color-picker-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "color-picker-nvim";
    src = inputs.color-picker-nvim;
  };
  colorful-winsep-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "colorful-winsep-nvim";
    src = inputs.colorful-winsep-nvim;
  };
  hlchunk-nvim-my = pkgs.vimUtils.buildVimPlugin {
    name = "hlchunk-nvim-my";
    src = inputs.hlchunk-nvim;
    doCheck = false;
  };

  univim-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "univim-nvim";
    src = inputs.univim-nvim;
    doCheck = false;
  };
  evergarden-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "evergaden-nvim";
    src = inputs.evergarden-nvim;
    doCheck = false;
  };
  # find sha256 nix-prefetch-url --unpack https://github.com/catppuccin/nvim/archive/0b2437bcc12b4021614dc41fcea9d0f136d94063.tar.gz
  catppuccin-nvim-patch = pkgs.vimUtils.buildVimPlugin {
    name = "catppuccin-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "0b2437bcc12b4021614dc41fcea9d0f136d94063";
      sha256 = "0zai4prpvcm6s2mnsfbg96pn21nvgrd13b2li19a9676v430rk64";
    };
    doCheck = false;
  };

  mkEntryFromDrv = drv:
    if lib.isDerivation drv
    then {
      name = "${lib.getName drv}";
      path = drv;
    }
    else drv;

  plugins = with pkgs.vimPlugins;
    [
      LazyVim
      snacks-nvim
      blink-cmp
      conform-nvim
      dressing-nvim
      flash-nvim
      friendly-snippets
      gitsigns-nvim
      headlines-nvim
      indent-blankline-nvim
      lualine-nvim
      neo-tree-nvim
      neoconf-nvim
      neodev-nvim

      nix-develop-nvim
      none-ls-nvim
      nvim-lspconfig
      nvim-lint

      noice-nvim
      nui-nvim
      nvim-notify

      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-ts-context-commentstring

      nvim-web-devicons
      oil-nvim
      persistence-nvim
      plenary-nvim
      sqlite-lua
      todo-comments-nvim
      tokyonight-nvim
      trouble-nvim
      vim-illuminate
      vim-startuptime
      # vscode-nvim
      which-key-nvim
      hydra-nvim
      bufferline-nvim
      dial-nvim
      focus-nvim

      glance-nvim
      glow-nvim
      render-markdown-nvim
      markdown-preview-nvim

      grug-far-nvim
      lazydev-nvim
      neotest
      nvim-nio
      nvim-window-picker
      persisted-nvim
      SchemaStore-nvim

      smart-splits-nvim
      ts-comments-nvim
      winshift-nvim
      color-picker-nvim
      colorful-winsep-nvim
      diffview-nvim

      hlchunk-nvim
      # {
      #   name = "hlchunk.nvim";
      #   path = hlchunk-nvim-my;
      # }
      neogit

      nvim-autopairs
      nvim-navic
      nvim-ufo
      promise-async
      rainbow-delimiters-nvim
      toggleterm-nvim
      nvim-spider
      substitute-nvim

      tabout-nvim

      {
        name = "LuaSnip";
        path = luasnip;
      }
      {
        name = "catppuccin";
        path = catppuccin-nvim-patch;
      }
      {
        name = "barbecue";
        path = barbecue-nvim;
      }
      {
        name = "color-picker.nvim";
        path = color-picker-nvim;
      }
      {
        name = "colorful-winsep.nvim";
        path = colorful-winsep-nvim;
      }
      {
        name = "mini.ai";
        path = mini-nvim;
      }
      {
        name = "mini.bufremove";
        path = mini-nvim;
      }
      {
        name = "mini.comment";
        path = mini-nvim;
      }
      {
        name = "mini.indentscope";
        path = mini-nvim;
      }
      {
        name = "mini.pairs";
        path = mini-nvim;
      }
      {
        name = "mini.surround";
        path = mini-nvim;
      }
      {
        name = "mini.hipatterns";
        path = mini-nvim;
      }
      {
        name = "mini.icons";
        path = mini-nvim;
      }
      {
        name = "yanky.nvim";
        path = yanky-nvim;
      }
    ]
    ++ lib.optionals (lib.elem "dap" extraPlugins) [
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
    ]
    ++ lib.optionals (lib.elem "cpp" extraPlugins) [
      {
        name = "cmake-tools.nvim";
        path = cmake-tools-nvim;
      }
      {
        name = "cmake-gtest.nvim";
        path = cmake-gtest-nvim;
      }
      clangd_extensions-nvim
    ]
    ++ lib.optionals (lib.elem "rust" extraPlugins) [
      crates-nvim
      rustaceanvim
    ]
    ++ lib.optionals (lib.elem "unity" extraPlugins) [
      omnisharp-extended-lsp-nvim
      {
        name = "UniVim.nvim";
        path = univim-nvim;
      }
    ]
    ++ lib.optionals (lib.elem "java" extraPlugins) [
      nvim-jdtls
    ]
    ++ lib.optionals (lib.elem "fancy" extraPlugins) [
      lsp-lens-nvim
      aerial-nvim
    ]
    ++ lib.optionals (lib.elem "neorg" extraPlugins) [
      neorg
      {
        name = "auto-save.nvim";
        path = autosave-nvim;
      }
    ]
    ++ lib.optionals (lib.elem "ai" extraPlugins) [
      windsurf-nvim
    ]
    ++ lib.optionals (lib.elem "extraTheme" extraPlugins) [
      dracula-nvim
      oxocarbon-nvim
      nord-nvim
      nordic-nvim
      {
        name = "gruvbox-material";
        path = gruvbox-material-nvim;
      }
      {
        name = "evergarden";
        path = evergarden-nvim;
      }
    ];
  # Link together all plugins into a single derivation
in
  pkgs.linkFarm "lazyvim-nix-plugins" (builtins.map mkEntryFromDrv plugins)
