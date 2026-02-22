-- init.lua — Neovim 0.11+ (no plugins, uv tools only)

---------- Settings ----------

vim.g.mapleader = "\\"

vim.o.clipboard = "unnamedplus"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.updatetime = 300

---------- Keybindings ----------

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-j>", "5<C-e>")
vim.keymap.set("n", "<C-k>", "5<C-y>")
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<F5>", [[<cmd>let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]])

---------- Ctrl-P (fzf in terminal buffer) ----------

vim.keymap.set("n", "<C-p>", function()
	local tmp = vim.fn.tempname()
	vim.cmd("enew")
	vim.fn.termopen('find . -path "*/.*" -prune -o -type f -print | fzf > ' .. tmp, {
		on_exit = function()
			vim.schedule(function()
				if vim.fn.filereadable(tmp) == 1 then
					local lines = vim.fn.readfile(tmp)
					vim.cmd("bdelete!")
					if #lines > 0 and lines[1] ~= "" then
						vim.cmd("edit " .. vim.fn.fnameescape(lines[1]))
					end
					vim.fn.delete(tmp)
				end
			end)
		end,
	})
	vim.cmd("startinsert")
end)

---------- LSP (Neovim 0.11 native) ----------

-- basedpyright: go-to-definition, hover, type diagnostics
vim.lsp.config("basedpyright", {
	cmd = { "basedpyright-langserver", "--stdio" },
	root_markers = { "pyproject.toml", ".git" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = { autoSearchPaths = true },
		},
	},
})

-- ruff: linting diagnostics + formatting
vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	root_markers = { "pyproject.toml", "ruff.toml", ".git" },
	filetypes = { "python" },
})

vim.lsp.enable({ "basedpyright", "ruff" })

-- 0.11+ auto-maps grr, grn, gra, K — but NOT gd (conflicts with vim builtin).
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
	end,
})

---------- Diagnostics ----------

vim.diagnostic.config({
	signs = false,
	virtual_text = false,
	underline = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

---------- Format on save (ruff LSP) ----------

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		vim.lsp.buf.format({ name = "ruff" })
	end,
})

---------- Python keybindings ----------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set("n", "<leader>l", function()
			vim.fn.setqflist({}, " ", {
				title = "ruff",
				lines = vim.fn.systemlist("ruff check " .. vim.fn.expand("%")),
			})
			vim.cmd("cwindow")
		end, { buffer = true, desc = "Ruff lint" })

		vim.keymap.set("n", "<leader>t", function()
			vim.fn.setqflist({}, " ", {
				title = "ty",
				lines = vim.fn.systemlist("ty check " .. vim.fn.expand("%")),
			})
			vim.cmd("cwindow")
		end, { buffer = true, desc = "ty typecheck" })
	end,
})

---------- Filetype overrides ----------

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "sh", "javascript", "tf" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.wo.wrap = true
		vim.wo.linebreak = true
	end,
})

---------- GitHub browse ----------

vim.api.nvim_create_user_command("Gbrowse", function(opts)
	vim.fn.system("gh browse " .. vim.fn.expand("%") .. ":" .. opts.line1 .. "-" .. opts.line2)
end, { range = true })

vim.keymap.set("n", "<leader>gb", "<cmd>Gbrowse<CR>")
vim.keymap.set("v", "<leader>gb", ":Gbrowse<CR>")

---------- LspCheck (debugging) ----------

vim.api.nvim_create_user_command("LspCheck", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("LSP: not attached (check :messages)")
	else
		local names = vim.tbl_map(function(c) return c.name end, clients)
		print("LSP: " .. table.concat(names, ", "))
	end
end, {})

---------- Theme ----------

vim.o.background = "dark"
vim.o.termguicolors = true
vim.cmd("colorscheme dracula")
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
