return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local acl = { ".", "," }
      for _, v in pairs(acl) do
        opts.keymap = vim.tbl_extend("force", opts.keymap, {
          [v] = {
            function(cmp)
              if cmp.accept() then
                vim.schedule(function()
                  vim.api.nvim_feedkeys(v, "n", true)
                end)
                return true
              end
            end,
            "fallback",
          },
        })
      end
    end,
  },
}
