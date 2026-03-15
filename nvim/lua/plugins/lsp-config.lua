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
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"pyright",
                    "rust_analyzer",
                    "clangd"
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config('ts_ls', {
				capabilities = capabilities,
			})
			vim.lsp.config('lua_ls', {
				capabilities = capabilities,
			})
			vim.lsp.config('pyright', {
				capabilities = capabilities,
			})
			vim.lsp.config('rust_analyzer', {
				capabilities = capabilities,
			})
			vim.lsp.config('clangd', {
				capabilities = capabilities,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "cd", vim.diagnostic.open_float, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
		end,
	},
}
