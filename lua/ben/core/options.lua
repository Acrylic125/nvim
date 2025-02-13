local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
	max_height = 10,
})

vim.o.pumheight = 15
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
	print("TESSSSSST ")
	if result.message:match("sourcekitd request timed out") then
		return -- Suppress this specific message
	end
	vim.lsp.handlers["window/showMessage"](nil, result, ctx)
end

local blocked_messages = {
	"sourcekit: -32001: sourcekitd request timed out", -- Example message to ignore
}

local original_notify = vim.notify

vim.notify = function(msg, ...)
	-- Print msg  with "HELLO:"
	for _, blocked in ipairs(blocked_messages) do
		if msg:match(blocked) then
			print("Blocked message: " .. msg)
			return -- Ignore this message
		end
	end
	original_notify(msg, ...)
end

-- vim.diagnostic.config({ signs = false, virtual_text = false })
