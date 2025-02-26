local setup, conform = pcall(require, "conform")
if not setup then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		swift = { "swiftformat" },
	},
	format_after_save = {
		lsp_format = "fallback",
	},
	-- Set the log level. Use `:ConformInfo` to see the location of the log file.
	log_level = vim.log.levels.ERROR,
	-- Conform will notify you when a formatter errors
	notify_on_error = true,
	-- Conform will notify you when no formatters are available for the buffer
	notify_no_formatters = true,
})
