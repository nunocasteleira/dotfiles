return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach Program (pwa-node, select pid)",
          cwd = vim.fn.getcwd(),
          processId = require("dap.utils").pick_process,
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Edge",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
      }
    end
  end,
}
