local M = {}

M.config = function()
	lvim.builtin.alpha.active = true
	lvim.builtin.alpha.mode = "dashboard"

	-----------------------------------------------------------------------dashboard--------------------------------------------------------------------------------
	local dashboard = try_require("alpha.themes.dashboard")
	local user_config_path = try_require("lvim.config"):get_user_config_path()

	if dashboard == nil then
		return
	end

	if user_config_path == nil then
		return
	end

	local header = {
		type = "text",
		val = {
			[[          ▀████▀▄▄              ▄█ ]],
			[[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
			[[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
			[[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
			[[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
			[[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
			[[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
			[[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
			[[   █   █  █      ▄▄           ▄▀   ]],
		},
		opts = {
			position = "center",
			hl = "Type",
		},
	}

	-- local builtin = require("telescope.builtin")
	-- local utils = require("telescope.utils")

	-- ["<leader>ff"] = { function() require("telescope.builtin").find_files({ cwd = utils.buffer_dir() }) end,
	--       desc = "Find files in cwd" }

	local buttons = {
		type = "group",
		val = {
			dashboard.button(
				"f",
				"Find File ",
				"<cmd>lua project_files()<cr>"
				-- '<cmd>lua require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir(), file_ignore_patterns = { "node_modules", ".git", "dist" } })<CR>'
			),
			dashboard.button("n", "New File ", "<cmd>ene!<CR>"),
			dashboard.button("p", "Recent Projects ", "<cmd>Telescope projects<CR>"),
			dashboard.button("e", "Recently Used Files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("t", "Find Word", "<cmd>FzfLua live_grep_native<CR>"),
			dashboard.button("c", "Configuration", "<cmd>edit " .. user_config_path .. "<CR>"),
			dashboard.button("q", "Quit", "<CMD>quit<CR>" .. user_config_path .. "<CR>"),
		},
		position = "center",
		opts = {
			spacing = 1,
			hl_shortcut = "Include",
		},
	}

	lvim.builtin.alpha.dashboard.config = {
		layout = {
			{ type = "padding", val = 2 },
			header,
			{ type = "padding", val = 3 },
			buttons,
		},
		opts = {
			margin = 7,
			setup = function()
				vim.cmd([[autocmd alpha_temp DirChanged * lua try_require('alpha').redraw()]])
			end,
		},
	}


vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "#000000", fg = "#ffffff" })

-- lvim.builtin.breadcrumbs.active = false
end

return M
