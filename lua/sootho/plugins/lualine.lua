return {
	"nvim-lualine/lualine.nvim",
	after = "catppuccin",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
	config = function()
		vim.cmd("colorscheme catppuccin-macchiato")
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- Custom component for Codeium status
		local function codeium_status()
			if vim.g.codeium_enabled then
				return ""
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

		-- Configure lualine with the catppuccin theme
		lualine.setup({
			options = {
				theme = "catppuccin-macchiato",
				icons_enabled = true,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp", "coc" } } },
				lualine_c = { "filename" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					codeium_status,
					copilot_status,
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "buffers" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "tabs" },
			},
			extensions = {},
		})
	end,
}
