vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require "mason".setup()
require "mini.pick".setup()
require "mini.diff".setup()
require "mini.bufremove".setup()
require "mini.icons".setup()
require "mini.snippets".setup()
require "mini.completion".setup()
require "mini.pairs".setup()
require "mini.comment".setup()
require "mini.surround".setup()
require "mini.extra".setup()

-- LSP
vim.lsp.enable(
	{
		"lua_ls",
		"pyright",
		"terraformls",
	}
)
vim.cmd [[set completeopt+=menuone,noselect,popup]]

local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
				and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		-- keymap.set("n", "gR", "<cmd>MiniExtra.pickers.lsp({ scope = 'references' })<CR>", opts) -- show definition, references
		keymap.set("n", "gR", "<cmd>Pick lsp scope='references'<CR>", opts) -- show definition, references

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "Show LSP definition"
		keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definition

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", "<cmd>Pick lsp scope='implementation'<CR>", opts) -- show lsp implementations

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		-- opts.desc = "Show buffer diagnostics"
		-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- jump to previous diagnostic in buffer
		--
		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

-- mappings
local map = vim.keymap.set
vim.g.mapleader = " "

-- system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')
map({ 'n', 'v' }, '<leader>c', ':')

-- Keybindings
map('n', '<leader>o', ':update<CR> :source <CR>')
map('i', 'jk', '<ESC>')

map('n', '<leader>lf', vim.lsp.buf.format)

map('n', '<leader>sf', "<Cmd>Pick files<CR>")
map('n', '<leader>sb', "<Cmd>Pick buffers<CR>")
map('n', '<leader>sh', "<Cmd>Pick help<CR>")
map('n', '<leader>sg', "<Cmd>Pick grep_live<CR>")
map('n', '<leader>sk', "<Cmd>Pick keymaps<CR>")
map('n', '<leader>se', "<Cmd>Pick explorer<CR>")

map('n', '<leader>e', "<Cmd>Oil<CR>")
map('i', '<c-e>', function() vim.lsp.completion.get() end)

map("n", "<M-n>", "<cmd>resize +2<CR>")          -- Increase height
map("n", "<M-e>", "<cmd>resize -2<CR>")          -- Decrease height
map("n", "<M-i>", "<cmd>vertical resize +5<CR>") -- Increase width
map("n", "<M-m>", "<cmd>vertical resize -5<CR>") -- Decrease width

map('n', '<leader>n', ':cnext<CR>', { noremap = true, silent = true })
map('n', '<leader>p', ':cprev<CR>', { noremap = true, silent = true })

-- Cover my mistakes for quitting nivm
vim.api.nvim_create_user_command("Q", "q", { bang = true })
vim.api.nvim_create_user_command("W", "w", { bang = true })
vim.api.nvim_create_user_command("WQ", "wq", { bang = true })
vim.api.nvim_create_user_command("Wq", "wq", { bang = true })
