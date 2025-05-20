return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      --More accept List
      -- local acl = { ".", "," }
      -- local acl = {}
      -- for _, v in pairs(acl) do
      --   opts.keymap = vim.tbl_extend("force", opts.keymap, {
      --     [v] = {
      --       function(cmp)
      --         if cmp.accept() then
      --           vim.schedule(function()
      --             vim.api.nvim_feedkeys(v, "n", true)
      --           end)
      --           return true
      --         end
      --       end,
      --       "fallback",
      --     },
      --   })
      -- end

      -- TODO:Not perfect sometime not working
      --Tabout compatibility
      opts.keymap = vim.tbl_extend("force", opts.keymap, {
        ["<Tab>"] = {
          "select_next",
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            end
          end,
          "snippet_backward",
          "fallback",
        },
      })
    end,
  },
}
