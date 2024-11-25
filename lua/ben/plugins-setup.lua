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
    use({ 'Everblush/nvim', as = 'everblush' })
    use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
    use("szw/vim-maximizer") -- maximizes and restores current window

    use("nvim-tree/nvim-tree.lua") -- file explorer
    use("nvim-tree/nvim-web-devicons")

    if packer_bootstrap then
        require('packer').sync()
    end
end)

