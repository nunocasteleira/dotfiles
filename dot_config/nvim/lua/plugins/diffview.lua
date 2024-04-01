return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
    { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
    { "<leader>gM", "<cmd>DiffviewOpen origin/master... --imply-local<CR>", desc = "Compare with master" },
  },
  opts = {},
}
