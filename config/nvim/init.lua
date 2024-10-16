-- Install the plugin manager 'lazy.nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("keymaps")
-- Load lazy.nvim and define plugins
require("lazy").setup({
    -- GitHub Copilot
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        end,
    },

    -- Telescope configuration
{
    "nvim-telescope/telescope.nvim",
    requires = { {"nvim-lua/plenary.nvim"} },  -- Dependency
    config = function()
        require('telescope').setup{
            defaults = {
                -- Configuración general (opcional)
            }
        }
    end
},
    -- LSP Support (for Rust, Go, Python, Terraform, etc.)
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Rust configuration
            lspconfig.rust_analyzer.setup {}

            -- Go configuration
            lspconfig.gopls.setup {}

            -- Python configuration
            lspconfig.pyright.setup {}

            -- Terraform configuration
            lspconfig.terraformls.setup {
            filetypes = { "terraform", "tf", "hcl" },
            on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            end,
            }
        end,
    },

    -- Autocompletion plugin
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp = require("cmp")
            cmp.setup {
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-y>"] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }),
            }
        end,
    },

    -- Snippet engine
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        requires = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup {}
            -- Keybinding to toggle the file tree
            vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeOpen<CR>', { noremap = true, silent = true })
        end,
    },

    -- Status line plugin
    { "nvim-lualine/lualine.nvim", config = true },

    -- Dracula theme
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd [[colorscheme tokyonight]]
        end,
    },

    -- Terraform syntax highlighting
    {
        "hashivim/vim-terraform",
        config = function()
            vim.g.terraform_align = 1 -- Auto-align = for terraform files
            vim.g.terraform_fmt_on_save = 1 -- Auto-format terraform files on save
        end,
    },

     -- Comment.nvim for easy commenting
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end
    },
    -- install with yarn or npm
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && yarn install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },
})
