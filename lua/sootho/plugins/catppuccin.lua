-- lua/sootho/plugins/catppuccin.lua
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 100, -- Set a lower priority value
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- Choose your flavor here
				background = {
					light = "latte",
					dark = "mocha",
				},
				-- ... (rest of the catppuccin configuration)
			})
			vim.cmd("colorscheme catppuccin-macchiato") -- Apply the colorscheme
		end,
	},
}
