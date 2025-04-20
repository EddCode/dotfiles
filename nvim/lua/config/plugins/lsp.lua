return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "pyright", "eslint" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = { "lua", "python", "typescript", "go" },
        opts = {
          library = {
            "lua_ls",
            "clangd",
            "pyright",
            "tsserver",
          },
        },
      }
    },
    config = function()
      local signs = {
        warn = "🔥",
        error = "💩",
        hint = "💡",
        info = "👀",
      }

      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup {
        signs = signs,
      }
      lspconfig.lua_ls.setup {
        signs = {
          warn = "🔥",
          error = "💩",
          hint = "💡",
          info = "👀",
        },
      }
      lspconfig.clangd.setup {
        signs = signs,
      }
      lspconfig.pyright.setup {
        signs = signs,
      }

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        signs = true,
        underline = true,
        severity_sort = true,
      })

      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "show 'diagnostic" })

      vim.keymap.set("n", "<leader>gd", function()
        vim.lsp.buf.definition()
      end, { desc = "Go to definition" })

      vim.keymap.set("n", "<leader>gr", function()
        vim.lsp.buf.references()
      end, { desc = "Go to references" })

      vim.keymap.set("n", "<leader>gi", function()
        vim.lsp.buf.implementation()
      end, { desc = "Go to implementation" })

      vim.keymap.set('n', '<leader>gdd', function()
        vim.lsp.buf.declaration()
      end, { desc = "Go to declaration" })

      vim.keymap.set('n', '<leader>D', function()
        vim.lsp.buf.type_definition()
      end, { desc = "Go to type definition" })

      -- autocomplete


      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if not client then
            return
          end

          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end
  },
}
