-- Line numbers
vim.opt.number = true

-- UI
vim.opt.cursorline = true

-- System clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.rtp:prepend("~/.config/nvim/lazy/lazy.nvim")


require("lazy").setup({
  { "folke/tokyonight.nvim", priority = 1000 },
  { "nvim-tree/nvim-tree.lua", version = "*", lazy = false },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "karb94/neoscroll.nvim", config = true },
})


require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "lua", "html", "bash", "json" },
  highlight = { enable = true },
})

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

require("lspconfig").gopls.setup({})

require("keymap")

vim.cmd.colorscheme("tokyonight-night")

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})

