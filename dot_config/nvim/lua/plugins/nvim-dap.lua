return {
  { "nvim-neotest/nvim-nio" },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
              "${port}",
            },
          },
        }
      end
      if not dap.adapters["node"] then
        dap.adapters["node"] = function(cb, config)
          if config.type == "node" then
            config.type = "pwa-node"
          end
          local nativeAdapter = dap.adapters["pwa-node"]
          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local vscode = require("dap.ext.vscode")
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes

      for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
        local pwaType = "pwa-" .. adapterType

        dap.adapters[pwaType] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }

        -- this allow us to handle launch.json configurations
        -- which specify type as "node" or "chrome" or "msedge"
        dap.adapters[adapterType] = function(cb, config)
          local nativeAdapter = dap.adapters[pwaType]

          config.type = pwaType

          if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
          else
            cb(nativeAdapter)
          end
        end
      end

      local enter_launch_url = function()
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
      end

      for _, language in ipairs(js_filetypes) do
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
          },
          -- {
          --   type = "pwa-chrome",
          --   request = "launch",
          --   name = "Launch Chrome (nvim-dap)",
          --   url = enter_launch_url,
          --   webRoot = "${workspaceFolder}",
          --   sourceMaps = true,
          -- },
          {
            type = "pwa-msedge",
            request = "launch",
            name = "Launch Edge (nvim-dap)",
            url = enter_launch_url,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
          -- Divider for the launch.json derived configs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "pwa-node",
            request = "launch",
          },
        }
      end
    end,
  },
}
