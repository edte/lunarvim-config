local M = {}

M.config = function()
	lvim.builtin.lualine.style = "none"

	if try_require("tmux-status") == nil then
		print("tmux-status not found")
		return
	end

	TmuxWindowName = {
		function()
			local res = "nil"
			res = vim.fn.system({ "tmux", "display-message", "-p", "#W" })
			res = res:gsub("%c", "") -- 删除所有控制字符
			-- print(res)
			return res
		end,
		cond = function()
			return require("tmux-status").show()
		end,
		color = { gui = "bold" },
	}

	local components = require("lvim.core.lualine.components")
	lvim.builtin.lualine.options.theme = "auto"
	lvim.builtin.lualine.options.globalstatus = true
	lvim.builtin.lualine.options.icons_enabled = lvim.use_icons
	lvim.builtin.lualine.options.component_separators = {
		left = lvim.icons.ui.DividerRight,
		right = lvim.icons.ui.DividerLeft,
	}
	lvim.builtin.lualine.options.section_separators = {
		left = lvim.icons.ui.BoldDividerRight,
		right = lvim.icons.ui.BoldDividerLeft,
	}
	lvim.builtin.lualine.options.disabled_filetypes = { "alpha" }
	lvim.builtin.lualine.sections.lualine_a = { components.mode }
	lvim.builtin.lualine.sections.lualine_b = {
		TmuxWindowName,
		"fileline",
	}
	lvim.builtin.lualine.sections.lualine_c = {
		components.branch,
		"diff",
	}
	lvim.builtin.lualine.sections.lualine_x = {
		components.diagnostics,
		components.lsp,
		components.filetype,
	}
	lvim.builtin.lualine.sections.lualine_y = {}
	lvim.builtin.lualine.sections.lualine_z = { "time" }
end

return M
