local M = {}

M.list = {
	-- 显示代码上下文,包含函数签名
	-- barbucue 的补充，显示更多
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		event = "BufRead",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{
				"nvim-treesitter/nvim-treesitter-refactor",
				event = "BufRead",
				after = "nvim-treesitter",
			},
			{
				"theHamsta/nvim-treesitter-pairs",
				event = "BufRead",
				after = "nvim-treesitter",
			},
			-- 语法感知文本对象、选择、移动、交换和查看支持。
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "BufRead",
				after = "nvim-treesitter",
			},

			-- 文本对象增强
			{
				"RRethy/nvim-treesitter-textsubjects",
				lazy = true,
				event = { "User FileOpened" },
				after = "nvim-treesitter",
			},
			{
				"David-Kunz/treesitter-unit",
				event = { "User FileOpened" },
				after = "nvim-treesitter",
			},
		},
		config = function()
			local r = try_require("text.treesitter")
			if r ~= nil then
				r.config()
			end
		end,
	},

	-- -- 使用treesitter自动关闭并自动重命名html标签
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "vue" },
		config = function()
			try_require("nvim-ts-autotag").setup()
		end,
	},

	-- 用于分割/合并代码块的 Neovim 插件
	{
		"Wansmer/treesj",
		cmd = { "Toggle" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			local treesj = try_require("treesj")
			if treesj == nil then
				return
			end
			treesj.setup({})

			vim.api.nvim_create_user_command("Toggle", function()
				require("treesj").toggle({ split = { recursive = true } })
			end, {})

			-- keymap("n", "K", "<cmd>Toggle<cr>")
		end,
	},

	-- {
	-- 	"Wansmer/sibling-swap.nvim",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	event = "VeryLazy",

	-- 	config = function()
	-- 		require("sibling-swap").setup({
	-- 			allowed_separators = {
	-- 				",",
	-- 				":",
	-- 				";",
	-- 				"and",
	-- 				"or",
	-- 				"&&",
	-- 				"&",
	-- 				"||",
	-- 				"|",
	-- 				"==",
	-- 				"===",
	-- 				"!=",
	-- 				"!==",
	-- 				"-",
	-- 				"+",
	-- 				["<"] = ">",
	-- 				["<="] = ">=",
	-- 				[">"] = "<",
	-- 				[">="] = "<=",
	-- 			},
	-- 			use_default_keymaps = true,
	-- 			-- Highlight recently swapped node. Can be boolean or table
	-- 			-- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
	-- 			-- `hl_opts` is a `val` from `nvim_set_hl()`
	-- 			highlight_node_at_cursor = true,
	-- 			-- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
	-- 			-- (`<C-,>` and `<C-.>` may not map to control chars at system level, so are sent by certain terminals as just `,` and `.`. In this case, just add the mappings you want.)
	-- 			keymaps = {
	-- 				["<a-1>"] = "swap_with_right",
	-- 				["<a-2>"] = "swap_with_left",
	-- 				["<space>."] = "swap_with_right_with_opp",
	-- 				["<space>,"] = "swap_with_left_with_opp",
	-- 			},
	-- 			ignore_injected_langs = false,
	-- 			-- allow swaps across lines
	-- 			allow_interline_swaps = true,
	-- 			-- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
	-- 			interline_swaps_without_separator = false,
	-- 			-- Fallbacs for tiny settings for langs and nodes. See #fallback
	-- 			fallback = {},
	-- 		})
	-- 	end,
	-- },

	-- 在 Neovim 中更改函数参数顺序！
	-- {
	-- 	"SleepySwords/change-function.nvim",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-treesitter/nvim-treesitter-textobjects", -- Not required, however provides fallback `textobjects.scm`
	-- 	},
	-- 	config = function()
	-- 		local change_function = require("change-function")
	-- 		change_function.setup({})
	-- 		vim.api.nvim_set_keymap("n", "<leader>lR", "", {
	-- 			callback = change_function.change_function,
	-- 		})
	-- 	end,
	-- },

	--使用 Treesitter 对 Neovim 中的几乎所有内容进行排序
	-- {
	-- 	"mtrajano/tssorter.nvim",
	-- 	version = "*", -- latest stable version, use `main` to keep up with the latest changes
	-- 	cmd = "Sort",
	-- 	config = function()
	-- 		require("tssorter").setup({
	-- 			-- leave empty for the default config or define your own sortables in here. They will add, rather than
	-- 			-- replace, the defaults for the given filetype
	-- 		})
	-- 		cmd("command! -nargs=* Sort lua require('tssorter').sort()")
	-- 	end,
	-- },

	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				"telescope",
				fzf_opts = { ["--cycle"] = "" },
				winopts = {
					fullscreen = true,
				},
			})
		end,
	},

	-- Telescope.nvim 扩展程序可在从编辑历史记录中选择文件时提供智能优先级。
	-- :Telescope frecency
	-- " Use a specific workspace tag:
	-- :Telescope frecency workspace=CWD
	-- " You can use with telescope's options
	-- :Telescope frecency workspace=CWD path_display={"shorten"} theme=ivy
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},

	-- 暂时没用到过
	-- 🚦 漂亮的诊断、参考、望远镜结果、快速修复和位置列表，可帮助您解决代码造成的所有问题。
	-- {
	-- 	"folke/trouble.nvim",
	-- 	opts = {}, -- for default options, refer to the configuration section for custom setup.
	-- 	cmd = "Trouble",
	-- },
}

require("text.bigfile").config()
require("text.diff").config()
require("text.input").config()

return M
