local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("ahmedkhalf/project.nvim")
	use("akinsho/nvim-toggleterm.lua")
	use("andymass/vim-matchup")
	use("ellisonleao/glow.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/vim-vsnip")
	use("kristijanhusak/orgmode.nvim")
	use("kristijanhusak/vim-dadbod-ui")
	use("kyazdani42/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons")
	use("lervag/vimtex")
	use("lewis6991/gitsigns.nvim")
	use("mbbill/undotree")
	use("mechatroner/rainbow_csv")
	use("mfussenegger/nvim-dap")
	use("neovim/nvim-lspconfig")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-hop.nvim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-live-grep-raw.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("onsails/lspkind-nvim")
  use("p00f/nvim-ts-rainbow")
	use("phaazon/hop.nvim")
	use("susliko/tla.nvim")
	use("ray-x/lsp_signature.nvim")
	use("rebelot/kanagawa.nvim")
  use("ruifm/gitlinker.nvim")
	use("tpope/vim-dadbod")
	use("ThePrimeagen/harpoon")
	use("scalameta/nvim-metals")
	use("simrat39/rust-tools.nvim")
	use("softinio/scaladex.nvim")
	use("tpope/vim-commentary")
	use("tpope/vim-scriptease")
	use("tpope/vim-surround")
	use("vim-utils/vim-man")
	use("wbthomason/packer.nvim")
	use("williamboman/nvim-lsp-installer")
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
