return {
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-jest"] = {
          args = {
            jestCommand = "npm test --",
            -- env = { CI = true },
            jestConfigFile = function(file)
              if string.find(file, "packages/") or string.find(file, "apps/") then
                return vim.fn.getcwd() .. "/" .. string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
              end

              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
            cwd = function(file)
              if string.find(file, "packages/") or string.find(file, "apps/") then
                return vim.fn.getcwd() .. "/" .. string.match(file, "(.-/[^/]+)/src")
              end

              return vim.fn.getcwd()
            end,
          },
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
