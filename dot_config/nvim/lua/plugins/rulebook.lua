local wk = require("which-key")
wk.add({
  { "<leader>r", group = "rulebook" }, -- group
})

return {
  {
    "chrisgrieser/nvim-rulebook",
    keys = {
      {
        "<leader>ri",
        function()
          require("rulebook").ignoreRule()
        end,
        desc = "Ignore rule (Rulebook)",
      },
      {
        "<leader>rl",
        function()
          require("rulebook").lookupRule()
        end,
        desc = "Lookup rule (Rulebook)",
      },
      -- rule for yank diagnostic code
      {
        "<leader>ry",
        function()
          require("rulebook").yankDiagnosticCode()
        end,
        desc = "Yank diagnostic code (Rulebook)",
      },
      {
        "<leader>rf",
        function()
          require("rulebook").suppressFormatter()
        end,
        desc = "Suppress formatter (Rulebook)",
        mode = { "n", "x" },
      },
    },
  },
}
