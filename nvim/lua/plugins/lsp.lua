-- ~/.config/nvim/lua/plugins/lsp.lua
-- Controls how LSP behaves: keys, error messages, completion, format on save.
-- Servers are installed by mason.lua, so this file only changes behavior.
--
-- Keys (Space is the leader key):
--   K            show documentation under the cursor
--   gd           go to definition
--   grr          list everywhere a name is used (references)
--   Space r      rename a name everywhere
--   Space a      code actions (quick fixes)
--   Space d      show the full error message on this line
--   Space F      format the file
--   ]d / [d      next / previous error
--
-- Completion: just type, the menu appears. Tab or Ctrl-n = next item,
-- Ctrl-y = accept, Ctrl-e = close.

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
}, { confirm = false })

-- ---------- 1. Server settings ----------
-- Only extra settings go here. Mason and lspconfig already know the rest.
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			-- Stops the false warning "undefined global vim"
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			telemetry = { enable = false },
		},
	},
})

-- ---------- 2. How errors and warnings look ----------
vim.o.winborder = "single"
vim.diagnostic.config({
	virtual_text = { spacing = 2, prefix = "●" }, -- message at end of the line
	signs = true, -- mark in the left column
	underline = true,
	update_in_insert = false, -- don't nag while typing
	severity_sort = true, -- errors before warnings
	float = { border = "single", source = true },
})

-- ---------- 3. Runs when a server connects to a file ----------
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local buf = ev.buf

		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
		end

		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("gt", vim.lsp.buf.type_definition, "Go to type")
		map("<leader>r", vim.lsp.buf.rename, "Rename")
		map("<leader>a", vim.lsp.buf.code_action, "Code action")
		map("<leader>d", vim.diagnostic.open_float, "Show error")
		map("<leader>F", function()
			vim.lsp.buf.format({ async = true })
		end, "Format file")

		-- Autocomplete (built into Neovim, no plugin needed)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
		end

		-- Format the file every time you save
		if client and client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup" }
