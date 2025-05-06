{ pkgs, inputs, lib, ... }:
let
  # Build plugins from github
  cmake-tools-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-tools.nvim";
    src = inputs.cmake-tools-nvim;
  };
  cmake-gtest-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-gtest.nvim";
    src = inputs.cmake-gtest-nvim;
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
    if lib.isDerivation drv then {
      name = "${lib.getName drv}";
      path = drv;
    } else
      drv;

  plugins = with pkgs.vimPlugins; [
    LazyVim
    snacks-nvim
    blink-cmp
    conform-nvim
    crates-nvim
    dressing-nvim
    flash-nvim
    friendly-snippets
    gitsigns-nvim
    headlines-nvim
    indent-blankline-nvim
    kanagawa-nvim
    lualine-nvim
    marks-nvim
    neo-tree-nvim
    neoconf-nvim
    neodev-nvim
    neorg
    nix-develop-nvim
    noice-nvim
    none-ls-nvim
    nui-nvim
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    nvim-lint
    nvim-lspconfig
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
    project-nvim
    rust-tools-nvim
    sqlite-lua
    todo-comments-nvim
    tokyonight-nvim
    trouble-nvim
    vim-illuminate
    vim-startuptime
    vscode-nvim
    which-key-nvim
    aerial-nvim
    hydra-nvim
    bufferline-nvim
    dial-nvim
    focus-nvim
    glance-nvim
    glow-nvim
    grug-far-nvim
    lazydev-nvim
    # lsp-lens-nvim
    markdown-preview-nvim
    neotest
    nvim-nio
    nvim-window-picker
    persisted-nvim
    rustaceanvim
    SchemaStore-nvim
    smart-splits-nvim
    ts-comments-nvim
    winshift-nvim
    color-picker-nvim
    colorful-winsep-nvim
    diffview-nvim
    {

      name = "hlchunk.nvim";
      path = hlchunk-nvim-my;
    }
    neogit
    nvim-autopairs
    nvim-navic
    nvim-ufo
    promise-async
    rainbow-delimiters-nvim
    toggleterm-nvim
    nvim-spider
    substitute-nvim
    smear-cursor-nvim
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
    # { name = "cmake-tools.nvim"; path = cmake-tools-nvim; }
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
  ];
  # Link together all plugins into a single derivation
in pkgs.linkFarm "lazyvim-nix-plugins" (builtins.map mkEntryFromDrv plugins)
