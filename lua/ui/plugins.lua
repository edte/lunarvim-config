local M = {}

M.list = {
	-- 一个漂亮的窗口，用于在一个地方预览、导航和编辑 LSP 位置，其灵感来自于 vscode 的 peek 预览。
	{
		"dnlhc/glance.nvim",
		config = function()
			require("glance").setup()
		end,
		cmd = "Glance",
	},

	-- 符号树状视图,按 S
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "S", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			outline_window = {
				auto_close = true,
				auto_jump = true,
				show_numbers = false,
				width = 35,
				wrap = true,
			},
			outline_items = {
				show_symbol_lineno = true,
				show_symbol_details = false,
			},
		},
	},

	-- wilder.nvim 插件，用于命令行补全，和 noice.nvim 冲突
	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter", -- 懒加载：首次进入cmdline时载入
		config = try_require("ui.wilder").wilderFunc,
	},

	{
		"echasnovski/mini.files",
		version = false,
		opts = {
			options = {
				use_as_default_explorer = false,
			},
			-- Customization of explorer windows
			windows = {
				-- Maximum number of windows to show side by side
				max_number = math.huge,
				-- Whether to show preview of file/directory under cursor
				preview = false,
				-- Width of focused window
				width_focus = 200,
				-- Width of non-focused window
				width_nofocus = 100,
			},
		},
		keys = {
			{
				"<space>e",
				function()
					local mf = require("mini.files")
					if not mf.close() then
						mf.open(vim.api.nvim_buf_get_name(0))
						mf.reveal_cwd()
					end
				end,
			},
		},
		config = function()
			-- nvim-tree
			-- vim.g.loaded_netrw = 1
			-- vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true

			-- vim.g.loaded_netrw = true -- or 1
			-- vim.g.loaded_netrwPlugin = true -- or 1

			lvim.builtin.nvimtree.setup.disable_netrw = false

			lvim.builtin.nvimtree.active = false
			lvim.builtin.nvimtree.setup.view.side = "left"
			lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
		end,
	},

	{
		"christopher-francisco/tmux-status.nvim",
		opts = {
			window = {
				separator = "  ",
				icon_zoom = "",
				icon_mark = "",
				icon_bell = "",
				icon_mute = "",
				icon_activity = "",
				text = "name",
			},
		},
	},

	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	dependencies = {
	-- 		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
	-- 		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	-- 	},
	-- 	init = function()
	-- 		vim.g.barbar_auto_setup = false
	-- 	end,
	-- 	opts = {
	-- 		-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
	-- 		-- animation = true,
	-- 		-- insert_at_start = true,
	-- 		-- …etc.
	-- 	},
	-- 	version = "^1.0.0", -- optional: only update when a new 1.x version is released
	-- },

	{
		"edte/lualine-ext",
	},
}

function ToggleMiniFiles()
	local mf = require("mini.files")
	if not mf.close() then
		mf.open(vim.api.nvim_buf_get_name(0))
		mf.reveal_cwd()
	end
end

require("ui.dashboard").config()
require("ui.terminal").config()
require("ui.theme").config()
require("ui.lualine").config()
require("ui.bufferbar").config()

return M
