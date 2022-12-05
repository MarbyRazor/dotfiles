local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

lsp.yamlls.setup({
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
				["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
			},
		},
	},
})

lsp.terraform_lsp.setup({})
--lsp.tflint.setup({})

lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
