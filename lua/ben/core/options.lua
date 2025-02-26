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

local notification_messages = {}
vim.notify = function(msg, level, opts)
	-- Store the message along with any level or option information
	table.insert(notification_messages, {
		message = msg,
		level = level,
		options = opts,
		timestamp = os.time(),
	})
end

-- Command to display all stored notification messages
vim.api.nvim_create_user_command("Msg", function()
	-- Create a buffer to display messages
	local buf_name = "Notification Messages"
	-- Check if buffer already exists
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_name(b):match(buf_name .. "$") then
			vim.api.nvim_buf_delete(b, { force = true })
			break
		end
	end
	local buf = vim.api.nvim_create_buf(false, true)

	-- Format the messages for display
	local lines = {}
	local lineColours = {}
	for _, notification in ipairs(notification_messages) do
		local time = os.date("%H:%M:%S", notification.timestamp)

		local level_str = "INFO"
		local hl_group = "Normal"

		if notification.level == vim.log.levels.ERROR then
			level_str = "ERROR"
			hl_group = "ErrorMsg"
		elseif notification.level == vim.log.levels.WARN then
			level_str = "WARN"
			hl_group = "WarningMsg"
		elseif notification.level == vim.log.levels.INFO then
			level_str = "INFO"
		elseif notification.level == vim.log.levels.DEBUG then
			level_str = "DEBUG"
		elseif notification.level == vim.log.levels.TRACE then
			level_str = "TRACE"
		end

		table.insert(lineColours, hl_group)
		table.insert(lines, string.format("[%s] %s %s", time, level_str, notification.message))
	end

	-- If no messages, show a placeholder
	if #lines == 0 then
		lines = { "No notification messages stored" }
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	for i, hl_group in ipairs(lineColours) do
		vim.api.nvim_buf_add_highlight(buf, -1, hl_group, i - 1, 0, -1)
	end
	vim.cmd("split")
	vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf)
	vim.api.nvim_buf_set_name(buf, buf_name)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
end, {})
