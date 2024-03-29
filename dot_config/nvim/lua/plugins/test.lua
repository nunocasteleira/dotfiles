return {
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-jest"] = {
          args = {
            jestCommand = "npm test --",
            jestConfigFile = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
              end
              if string.find(file, "apps/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
              end

              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },
  },
}
