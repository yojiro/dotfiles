-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to clone lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Python provider
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim-python/bin/python")

-- Options
vim.opt.encoding     = "utf-8"
vim.opt.fileencodings = "utf-8,iso-2022-jp,euc-jp,sjis,cp932"
vim.opt.fileformats  = "unix,dos,mac"
vim.opt.termguicolors = true
vim.opt.backup       = false
vim.opt.swapfile     = false
vim.opt.hlsearch     = true
vim.opt.ignorecase   = true
vim.opt.smartcase    = true
vim.opt.infercase    = true
vim.opt.laststatus   = 2
vim.opt.wrap         = false
vim.opt.wildmenu     = true
vim.opt.showcmd      = true
vim.opt.autoindent   = true
vim.opt.shiftround   = true
vim.opt.shiftwidth   = 2
vim.opt.softtabstop  = 2
vim.opt.expandtab    = true
vim.opt.tabstop      = 2
vim.opt.showtabline  = 2
vim.opt.smarttab     = true
vim.opt.foldmethod   = "syntax"
vim.opt.spelllang    = { "en", "cjk" }
vim.opt.timeout      = true
vim.opt.timeoutlen   = 500
vim.opt.nrformats    = "hex"
vim.opt.mouse        = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.matchpairs:append("<:>")

-- Keymaps
vim.keymap.set("i", "<C-j>", "<esc>")
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR><Esc>")
vim.keymap.set({ "n", "v" }, "<Tab>", "%")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

require("lazy").setup({
  -- Git
  { "tpope/vim-fugitive" },

  -- Editing
  { "tpope/vim-surround" },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "<Enter>", "<Plug>(EasyAlign)", mode = "v" },
      { "<Leader>a", "<Plug>(EasyAlign)", mode = "n" },
    },
  },
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case",
        },
      },
    },
    keys = {
      { "<C-u><C-p>", function() require("telescope.builtin").find_files() end },
      { "<C-u><C-j>", function() require("telescope.builtin").current_buffer_fuzzy_find() end },
      { "<C-u><C-g>", function() require("telescope.builtin").live_grep() end },
      { "<C-u><C-]>", function() require("telescope.builtin").grep_string() end },
      { "<C-u><C-u>", function() require("telescope.builtin").oldfiles() end },
      { "<C-u><C-y>", function() require("telescope.builtin").registers() end },
      { "<C-u><C-r>", function() require("telescope.builtin").resume() end },
      { "<C-u><C-d>", function() require("telescope.builtin").find_files({ cwd = "~/dotfiles" }) end },
    },
  },

  -- Syntax / indent
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python", "go", "javascript", "typescript",
          "html", "css", "markdown", "toml", "json",
          "lua", "vim", "vimdoc",
        },
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options  = { theme = "auto", globalstatus = true },
      sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
      },
      tabline = {
        lualine_a = { "buffers" },
        lualine_z = { "tabs" },
      },
    },
  },

  -- Go
  {
    "fatih/vim-go",
    ft = "go",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local map = function(k, v) vim.keymap.set("n", k, v, { buffer = true }) end
          map("<leader>r",  "<Plug>(go-run)")
          map("<leader>b",  "<Plug>(go-build)")
          map("<leader>t",  "<Plug>(go-test)")
          map("<leader>c",  "<Plug>(go-coverage)")
          map("<Leader>ds", "<Plug>(go-def-split)")
          map("<Leader>dv", "<Plug>(go-def-vertical)")
          map("<Leader>dt", "<Plug>(go-def-tab)")
          map("<Leader>gd", "<Plug>(go-doc)")
          map("<Leader>gv", "<Plug>(go-doc-vertical)")
        end,
      })
    end,
  },

  -- Web
  {
    "mattn/emmet-vim",
    ft = { "eruby", "html", "gohtmltmpl" },
    init = function()
      vim.g.use_emmet_complete_tag = 1
      vim.g.user_emmet_settings = { lang = "ja", html = { indentation = "  " } }
    end,
  },
  { "othree/html5.vim" },
  { "wavded/vim-stylus" },
  { "pangloss/vim-javascript" },

  -- Markdown / text
  { "tpope/vim-markdown" },

  -- Browser
  {
    "tyru/open-browser.vim",
    keys = { { "gx", "<Plug>(openbrowser-smart-search)", mode = { "n", "v" } } },
    init = function() vim.g.netrw_nogx = 1 end,
  },

  -- Memo
  {
    "glidenote/memolist.vim",
    keys = {
      { "mn", ":MemoNew<CR>" },
      { "mg", ":MemoGrep<CR>" },
      { "ml", function()
        require("telescope.builtin").find_files({ cwd = vim.g.memolist_path })
      end },
    },
    init = function()
      vim.g.memolist_gfixgrep            = 1
      vim.g.memolist_filename_prefix_none = 1
      vim.g.memolist_path                = vim.fn.expand("~/GoogleDrive/memolist")
    end,
  },
}, {
  checker = { enabled = false },
})

-- Colorscheme
vim.cmd.syntax("on")
local ok, _ = pcall(vim.cmd.colorscheme, "yuo8")
if not ok then vim.cmd.colorscheme("default") end
vim.api.nvim_set_hl(0, "CursorLine", { fg = "#E19972" })
