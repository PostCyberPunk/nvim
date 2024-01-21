if false then
  return {

    {
      "mfussenegger/nvim-dap",
      keys = {
        { "<leader>dw", false },
        {
          "<leader>dh",
          function()
            require("dap.ui.widgets").hover()
          end,
          desc = "Hove",
        },
        {
          "<leader>dP",
          function()
            require("dap").pause()
          end,
          desc = "Pause",
        },
        {
          "<leader>dp",
          function()
            require("dap.ui.widgets").preview()
          end,
          desc = "preview",
        },
      },
    },
    {
      "rcarriga/nvim-dap-ui",
  -- stylua: ignore
  keys = {
    { "<leader>dW", function() require("dapui").float_element('watches',{enter=true,width=60,height=30}) end, desc = "Dap UI" },
    { "<leader>dw", function() require("dapui").elements.watches.add() end, desc = "Dap UI",mode={"n","v"}},
  },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        opts.icons = {
          collapsed = "+",
        }
        opts.layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.25,
              },
              {
                id = "breakpoints",
                size = 0.25,
              },
              {
                id = "stacks",
                size = 0.25,
              },
              {
                id = "watches",
                size = 0.25,
              },
            },
            position = "left",
            size = 40,
          },
        }
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
  }
  else
  return{}
end
