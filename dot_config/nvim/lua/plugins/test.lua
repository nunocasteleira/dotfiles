return {
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          -- env = { CI = true },
          jestConfigFile = function(file)
            if string.find(file, "/apps/") or string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end

            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          cwd = function(file)
            if string.find(file, "/apps/") or string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end
            return vim.fn.getcwd()
          end,
        },
      },
    },
    keys = {
      {
        "<leader>tc",
        function()
          require("neotest").output_panel.clear()
        end,
        desc = "Clear Output Panel",
      },
    },
  },
}
