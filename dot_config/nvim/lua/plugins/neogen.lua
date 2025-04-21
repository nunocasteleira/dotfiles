local wk = require("which-key")
wk.add({
  { "<leader>N", group = "neogen" }, -- group
})

return {
  {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    keys = {
      {
        "<leader>Nf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "generate function documentation",
      },
      {
        "<leader>Nc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        desc = "generate class documentation",
      },
      {
        "<leader>Nt",
        function()
          require("neogen").generate({ type = "type" })
        end,
        desc = "generate type documentation",
      },
    },
    opts = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
    end,
  },
}
