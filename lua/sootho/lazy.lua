local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- Import your existing plugins (including catppuccin)
	{ import = "sootho.plugins" },
	{ import = "sootho.plugins.lsp" },
	-- Configure lualine
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local lualine = require("lualine")
			local lazy_status = require("lazy.status")
			-- Custom component for Codeium status
			local function codeium_status()
				if vim.g.codeium_enabled then
					return ""
				else
					return ""
				end
			end
			-- Custom component for GitHub Copilot status
			local function copilot_status()
				local status = vim.fn["copilot#Enabled"]()
				if status == 1 then
					return "Copilot"
				else
					return "Copilot: Off"
				end
			end
			-- Configure lualine
			lualine.setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "|" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
				},
				sections = {
					lualine_x = {
						{
							lazy_status.updates,
							cond = lazy_status.has_updates,
							color = { fg = "#ff9e64" },
						},
						{ codeium_status },
						{ copilot_status },
						{ "encoding" },
						{ "fileformat" },
						{ "filetype" },
					},
				},
			})
		end,
	},
	-- Add other plugins here...
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
