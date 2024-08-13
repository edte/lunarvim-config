local M = {}

M.list = {
	-- 展示颜色
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			local r = try_require("components.color")
			if r ~= nil then
				r.colorConfig()
			end
		end,
	},

	--HACK:
	--TODO:
	--FIX:
	--NOTE:
	--WARNING:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		-- cmd = { "Todo", "TodoQuickFix", "TodoTelescope", "TodoTrouble", "TodoLocList" },
		config = function()
			try_require("todo-comments").setup({})

			local telescope = try_require("telescope")
			if telescope == nil then
				return
			end
			telescope.setup({
				extensions = {
					["todo-comments"] = {},
				},
			})
			telescope.load_extension("todo-comments")

			Del_cmd("TodoQuickFix")
			Del_cmd("TodoTelescope")
			Del_cmd("TodoTrouble")
			Del_cmd("TodoLocList")

			cmd("command! -nargs=* Todo Telescope todo-comments todo <args>")
		end,
	},

	-- Neovim 中人类可读的内联 cron 表达式
	{
		"fabridamicelli/cronex.nvim",
		opts = {},
		ft = { "go" },
		config = function()
			local r = try_require("components.cron")
			if r ~= nil then
				r.cronConfig()
			end
		end,
	},

	-- 翻译插件
	{
		cmd = { "Translate" },
		"uga-rosa/translate.nvim",
	},

	-- -- 临时文件
	-- {
	-- 	"LintaoAmons/scratch.nvim",
	-- 	config = function()
	-- 		require("scratch").setup({
	-- 			scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- where your scratch files will be put
	-- 			filetypes = { "lua", "json", "sh", "go", "txt", "cpp", "c", "md" }, -- you can simply put filetype here
	-- 			filetype_details = { -- or, you can have more control here
	-- 				json = {}, -- empty table is fine
	-- 				["project-name.md"] = {
	-- 					subdir = "project-name", -- group scratch files under specific sub folder
	-- 				},
	-- 				["yaml"] = {},
	-- 				go = {
	-- 					requireDir = true, -- true if each scratch file requires a new directory
	-- 					filename = "main", -- the filename of the scratch file in the new directory
	-- 					content = { "package main", "", "func main() {", "  ", "}" },
	-- 					cursor = {
	-- 						location = { 4, 2 },
	-- 						insert_mode = true,
	-- 					},
	-- 				},
	-- 			},
	-- 			window_cmd = "rightbelow vsplit", -- 'vsplit' | 'split' | 'edit' | 'tabedit' | 'rightbelow vsplit'
	-- 			use_telescope = true,
	-- 			localKeys = {
	-- 				{
	-- 					filenameContains = { "sh" },
	-- 					LocalKeys = {
	-- 						{
	-- 							cmd = "<CMD>RunShellCurrentLine<CR>",
	-- 							key = "<C-r>",
	-- 							modes = { "n", "i", "v" },
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	event = "VeryLazy",
	-- },

	-- -- 中文排版自动规范化的 Vim 插件
	-- -- { "hotoo/pangu.vim" },

	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			-- You will not need this if you installed the
			-- parsers manually
			-- Or if the parsers are in your $RUNTIMEPATH

			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("markview").setup({})
		end,
	},

	-- {
	-- 	"MeanderingProgrammer/markdown.nvim",
	-- 	main = "render-markdown",
	-- 	ft = { "markdown", "norg" },
	-- 	opts = {},
	-- 	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- },

	-- 显示图片，和markdown.nvim一起使用，但是现在和tmux不兼容，切不同窗口图片都还在，故先注释掉
	-- lazy snippet
	-- {
	-- 	"3rd/image.nvim",
	-- 	branch = "pr/199",
	-- 	-- cond = false,
	-- 	-- ft = { "markdown", "norg", "image_nvim" },
	-- 	build = "luarocks --local install magick --lua-version 5.1",
	-- 	config = function()
	-- 		package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
	-- 		package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

	-- 		require("image").setup({
	-- 			backend = "kitty",
	-- 			-- backend = "ueberzug",
	-- 			integrations = {
	-- 				markdown = {
	-- 					enabled = true,
	-- 					clear_in_insert_mode = false,
	-- 					download_remote_images = true,
	-- 					only_render_image_at_cursor = false,
	-- 					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
	-- 				},
	-- 				neorg = {
	-- 					enabled = true,
	-- 					clear_in_insert_mode = false,
	-- 					download_remote_images = true,
	-- 					only_render_image_at_cursor = false,
	-- 					filetypes = { "norg" },
	-- 				},
	-- 			},
	-- 			max_width = nil,
	-- 			max_height = nil,
	-- 			max_width_window_percentage = nil,
	-- 			max_height_window_percentage = 50,
	-- 			window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
	-- 			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	-- 			editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	-- 			tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	-- 			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
	-- 		})
	-- 	end,
	-- },

	-- precognition.nvim - 预识别使用虚拟文本和装订线标志来显示可用的动作。
	-- Precognition toggle
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	opts = {},
	-- },

	-- Neovim 插件帮助您建立良好的命令工作流程并戒掉坏习惯
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("hardtime").setup({
				disable_mouse = false,
				restricted_keys = {
					-- ["j"] = {},
					-- ["k"] = {},
				},
				disabled_keys = {
					["<Up>"] = {},
					["<Down>"] = {},
					["<Left>"] = {},
					["<Right>"] = {},
				},
			})
		end,
	},

	-- 使用 curl 运行请求，使用 jq 格式化，并根据您自己的工作流程保存命令
	-- 这些命令将打开 curl.nvim 选项卡。在左侧缓冲区中，您可以粘贴或写入 curl 命令，然后按 Enter 键，命令将执行，并且输出将在最右侧的缓冲区中显示和格式化。
	-- 如果您愿意，您可以选择右侧缓冲区中的文本，并使用 jq 对其进行过滤，即 ggVG! jq '{query goes here}'
	{
		"oysandvik94/curl.nvim",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},

	-- 跟踪在 Neovim 中编码所花费的时间
	{
		"ptdewey/pendulum-nvim",
		config = function()
			require("pendulum").setup({
				log_file = vim.fn.expand("$HOME/Documents/my_custom_log.csv"),
				timeout_len = 300, -- 5 minutes
				timer_len = 60, -- 1 minute
				gen_reports = true, -- Enable report generation (requires Go)
				top_n = 10, -- Include top 10 entries in the report
			})
		end,
	},
}

return M
