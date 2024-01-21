if false then
  return {
    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        -- old unity debugger
        dap.adapters.unity = {
          type = "executable",
          command = "/usr/bin/mono",
          args = { os.getenv("HOME") .. "/.vscode/extensions/deitry.unity-debug-3.0.11/bin/UnityDebug.exe" },
        }
        dap.configurations.cs = {
          {
            type = "unity",
            request = "attach",
            name = "Unity Editor",
            path = vim.fn.getcwd() .. "/Library/EditorInstance.json",
            -- path = "/home/buzz/UnityProject/Lidow/Library/EditorInstance.json",
          },
        }
        -- vstuc
        -- dap.adapters.vstuc = {
        --   type = "executable",
        --   command = "/usr/bin/dotnet",
        --   -- command = os.getenv('HOME').."/"
        --   args = {
        --     os.getenv("HOME") .. "/.vscode/extensions/visualstudiotoolsforunity.vstuc-0.9.3/bin/UnityDebugAdapter.dll",
        --   },
        --   name = "Attach to Unity",
        -- }
        -- dap.configurations.cs = {
        --   {
        --     name = "Attach to Unity",
        --     type = "vstuc",
        --     request = "attach",
        --     endPoint = "127.0.0.1:56463",
        --     logFile = os.getenv("HOME") .."/vstuc.log.txt",
        --   },
        -- }
      end,
    },
  }
  else
  return{}
end
