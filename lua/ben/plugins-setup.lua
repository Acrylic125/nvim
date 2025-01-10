-- https://www.youtube.com/watch?v=vdn_pKJUda9

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- TODO: Change the path to the absolute path of the venv
-- comprising your neovim's python deps.
local python_venv_path = "/Users/benedicttan/.config/nvim/python/neovim/bin/python3"
vim.g.python3_host_prog = vim.fn.expand(python_venv_path)

-- add list of plugins to install
return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
	use("navarasu/onedark.nvim") -- color scheme
	-- use("folke/tokyonight.nvim") -- color scheme
	-- use({ 'Everblush/nvim', as = 'everblush' })
	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
	use("szw/vim-maximizer") -- maximizes and restores current window

	use("nvim-tree/nvim-tree.lua") -- file explorer
	use("nvim-tree/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim") -- statusline

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
		end,
	})
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use({
		"nvimtools/none-ls.nvim",
		requires = {
			"nvimtools/none-ls-extras.nvim",
		},
	}) -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- Jupyter Notebooks
	-- use({
	--     "benlubas/molten-nvim",
	--     version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	--     build = ":UpdateRemotePlugins",
	-- })

	-- Lush, for custom themes.
	-- use('rktjmp/lush.nvim')

	-- Auto pair
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Comments
	use({
		"numToStr/Comment.nvim",
		-- config = function()
		-- 	require("Comment").setup({
		-- 		mappings = {
		-- 			-- Disable the default mappings
		-- 			basic = false,
		-- 			-- Disable extra mappings
		-- 			extra = false,
		-- 		},
		-- 		-- Custom keymapping
		-- 		-- toggler = {
		-- 		-- 	line = "<C-/>",
		-- 		-- },
		-- 		-- opleader = {
		-- 		-- 	line = "<C-/>",
		-- 		-- },
		-- 	})
		--
		-- 	vim.keymap.set("x", "<C-_>", function()
		-- 		require("Comment.api").toggle.linewise.visual()
		-- 	end, { noremap = true, silent = true })
		-- 	vim.keymap.set("n", "<C-_>", function()
		-- 		require("Comment.api").toggle.linewise.current()
		-- 	end, { noremap = true, silent = true })
		-- 	print("Test Comment 4")
		-- end,
	})

	-- Harpoon
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"MysticalDevil/inlay-hints.nvim",
		requires = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
