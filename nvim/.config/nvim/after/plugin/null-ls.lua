local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
	return
end

mason_null_ls.setup({
	ensure_installed = { "stylua", "jq", "markdownlint", "terrafmt", "terraform_fmt" },
	automatic_setup = true,
})

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	-- b.formatting.deno_fmt,
	b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }),

	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

	b.formatting.yamlfmt,
	b.formatting.jq,
	b.formatting.terraform_fmt,
	b.formatting.terrafmt, -- Formatting terraform in markdown
}

null_ls.setup({
	debug = true,
	sources = sources,
	-- Testing Format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
