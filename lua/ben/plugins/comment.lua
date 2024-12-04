local status, comment = pcall(require, "Comment")
if not status then
	return
end

comment.setup({
	mappings = {
		-- Disable the default mappings
		basic = false,
		-- Disable extra mappings
		extra = false,
	},
})

vim.keymap.set("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { noremap = true, silent = true })
vim.keymap.set("n", "<C-_>", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
