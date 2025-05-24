return {
  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require("dap")
      -- old unity debugger
      -- dap.adapters.unity = {
      --   type = "executable",
      --   command = "/usr/bin/mono",
      --   -- FIX: use the correct path for the UnityDebug.exe
      --   args = { os.getenv("HOME") .. "/.vscode/extensions/deitry.unity-debug-3.0.11/bin/UnityDebug.exe" },
      -- }
      -- dap.configurations.cs = {
      --   {
      --     type = "unity",
      --     request = "attach",
      --     name = "Unity Editor",
      --     path = vim.fn.getcwd() .. "/Library/EditorInstance.json",
      --     -- path = "/home/buzz/UnityProject/Lidow/Library/EditorInstance.json",
      --   },
      -- }
      -- vstuc
      local vstuc_path = vim.g.runtime_path .. "/share/vscode/extensions/VisualStudioToolsForUnity.vstuc/bin"
      if vim.g.isnix ~= 1 then
        vstuc_path = os.getenv("VSTUC_BIN_PATH")
      end
      dap.adapters.vstuc = {
        type = "executable",
        command = "dotnet",
        -- command = os.getenv('HOME').."/"
        args = { vstuc_path .. "/UnityDebugAdapter.dll" },
      }
      dap.configurations.cs = {
        {
          name = "Attach to Unity",
          type = "vstuc",
          request = "attach",
          path = vim.fn.getcwd() .. "/Library/EditorInstance.json",
          logFile = vim.env.XDG_CACHE_HOME .. "/vstuc.log",
          endPoint = function()
            local system_obj = vim.system({ "dotnet", vstuc_path .. "/UnityAttachProbe.dll" })
            local probe_result = system_obj:wait(2000).stdout

            if probe_result == nil or #probe_result == 0 then
              print("No endpoint found (is unity running?)")
              return ""
            end
            local pattern = [["debuggerPort":(%d+)]]
            local port = string.match(probe_result, pattern)

            if port == nil or #port == 0 then
              print("Failed to parse debugger port")
              return ""
            end
            vim.notify("Conecting to Unity with port:" .. port)

            return "127.0.0.1:" .. port
          end,
        },
      }
    end,
  },
}
