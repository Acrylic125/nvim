-- https://www.youtube.com/watch?v=vdn_pKJUda8

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
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

-- add list of plugins to install
return packer.startup(function(use)
    use('wbthomason/packer.nvim')
    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
    use("navarasu/onedark.nvim") -- color scheme
    -- use("folke/tokyonight.nvim") -- color scheme
    -- use({ 'Everblush/nvim', as = 'everblush' })
    use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
    use("szw/vim-maximizer") -- maximizes and restores current window

    use("nvim-tree/nvim-tree.lua") -- file explorer
    use("nvim-tree/nvim-web-devicons")
    use("nvim-lualine/lualine.nvim")  -- statusline

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
    use ({
       'nvimdev/lspsaga.nvim',
       after = 'nvim-lspconfig',
       config = function()
           require('lspsaga').setup({})
       end,
    })
    -- use({ 
    --     "glepni r/lspsaga.nvim",
    --     branch  = "main",
    --     require = {
    --         { "nv im-tree/nvim-web-devicons" },
    --         { "nv im-treesitter/nvim-treesitter" },
    --     },
    -- }) -- enh anced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- Lush, for custom themes.
    use('rktjmp/lush.nvim')
    -- Auto pair 
    use({
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    })

    if packer_bootstrap then
        require('packer').sync()
    end
end)

