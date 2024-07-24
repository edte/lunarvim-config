-- --=================================================vim plugins install=======================================================
--
lvim.plugins = {
	--------------------------------------------ui相关------------------------------------------------------------------------------------------------
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
				auto_close = false,
				auto_jump = true,
				show_numbers = false,
				-- width = 20,
				-- wrap = true,
			},
			outline_items = {
				show_symbol_lineno = true,
				show_symbol_details = true,
			},
		},
	},

	-------------------------------------------------------vim 基础功能增强-------------------------------------------------------------------------------------
	-- -- 查看 Vim 标记并与之交互的用户体验更好。
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			local r = try_require("text.mark")
			if r ~= nil then
				r.marksConfig()
			end
		end,
	},

	-- 文件mark，按git隔离
	-- 保存目录 /Users/edte/.cache/lvim/arrow
	{
		"otavioschwanck/arrow.nvim",
		event = "VeryLazy",
		opts = {
			show_icons = true,
			leader_key = "`", -- Recommended to be a single key
			-- buffer_leader_key = "m", -- Per Buffer Mappings
			index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
			save_key = "cwd", -- what will be used as root to save the bookmarks. Can be also `git_root`.
			hide_handbook = true,
			always_show_path = true,
		},
	},

	-- echo stdpath("data")
	-- ~/.local/share/nvim/bookmarks/
	{
		"crusj/bookmarks.nvim",
		branch = "main",
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("bookmarks").setup({
				storage_dir = "", -- Default path: vim.fn.stdpath("data").."/bookmarks,  if not the default directory, should be absolute path",
				mappings_enabled = true, -- If the value is false, only valid for global keymaps: toggle、add、delete_on_virt、show_desc
				keymap = {
					toggle = " mt", -- Toggle bookmarks(global keymap)
					close = "<esc>", -- close bookmarks (buf keymap)
				},
			})
			require("telescope").load_extension("bookmarks")

			lvim.builtin.which_key.mappings["mm"] = {
				"<cmd>lua require'bookmarks'.add_bookmarks(fasle)<cr>",
				"mark",
			}

			lvim.builtin.which_key.mappings["md"] = {
				"<cmd>lua require'bookmarks.list'.delete_on_virt()<cr>",
				"delete",
			}

			-- lvim.builtin.which_key.mappings["mo"] = {
			-- 	"<cmd>lua require'bookmarks'.toggle_bookmarks()<cr>",
			-- 	"Goto",
			-- }

			lvim.builtin.which_key.mappings["mo"] = {
				"<cmd>Telescope bookmarks<cr>",
				"Goto",
			}
		end,
	},

	-- 使用“.”启用重复支持的插件映射
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},

	-- 增强 Neovim 中宏的使用。
	{
		"chrisgrieser/nvim-recorder",
		event = "RecordingEnter",
		keys = {
			-- these must match the keys in the mapping config below
			{ "q", desc = " Start Recording" },
			{ "Q", desc = " Play Recording" },
		},
		config = function()
			local r = try_require("text.record")
			if r ~= nil then
				r.recoderConfig()
			end
		end,
	},

	-- -- 块移动
	-- {
	-- 	"fedepujol/move.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		try_require("move").setup({
	-- 			line = {
	-- 				enable = true, -- Enables line movement
	-- 				indent = true, -- Toggles indentation
	-- 			},
	-- 			block = {
	-- 				enable = true, -- Enables block movement
	-- 				indent = true, -- Toggles indentation
	-- 			},
	-- 			word = {
	-- 				enable = true, -- Enables word movement
	-- 			},
	-- 			char = {
	-- 				enable = false, -- Enables char movement
	-- 			},
	-- 		})
	-- 		-- local opts = { noremap = true, silent = true }
	-- 		-- -- Visual-mode commands
	-- 		-- vim.keymap.set("v", "<S-j>", ":MoveBlock(1)<CR>", opts)
	-- 		-- vim.keymap.set("v", "<S-k>", ":MoveBlock(-1)<CR>", opts)
	-- 		-- vim.keymap.set("v", "<S-h>", ":MoveHBlock(-1)<CR>", opts)
	-- 		-- vim.keymap.set("v", "<S-l>", ":MoveHBlock(1)<CR>", opts)
	-- 	end,
	-- },

	-- 扩展递增/递减 ctrl+x/a
	-- {
	-- 	"monaqa/dial.nvim",
	-- 	config = function()
	-- 		local r = try_require("text.number")
	-- 		if r ~= nil then
	-- 			r.numberConfig()
	-- 		end
	-- 	end,
	-- },

	-- vim/neovim 的多光标插件
	-- 使用 Ctrl-D 选择单词
	-- 使用 Ctrl-Down/Ctrl-Up 垂直创建光标
	-- 使用 Shift-箭头一次选择一个字符
	-- 按 n/N 获取下一个/上一个出现的情况
	-- 按 [/] 选择下一个/上一个光标
	-- 按 q 跳过当前并获取下一个出现的位置
	-- 按 Q 删除当前光标/选择
	-- 使用 i,a,I,A 启动插入模式
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = "VeryLazy",
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>",
			}
		end,
	},

	-- 不是天空中的 UFO，而是 Neovim 中的超级折叠。 za
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			local r = try_require("text.fold")
			if r ~= nil then
				r.foldConfig()
			end
		end,
	},

	-- FIX: 这个插件有问题，会报 CursorHold 错误
	-- -- vim match-up：% 更好的导航和突出显示匹配单词现代 matchit 和 matchparen。支持 vim 和 neovim + tree-sitter。
	-- {
	-- 	"andymass/vim-matchup",
	-- 	init = function()
	-- 		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	-- 	end,
	-- },

	{
		"chrisgrieser/nvim-various-textobjs",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			try_require("various-textobjs").setup({
				useDefaultKeymaps = true,
				lookForwardLines = 10,
			})
			-- example: `an` for outer subword, `in` for inner subword
			vim.keymap.set({ "o", "x" }, "aS", function()
				try_require("various-textobjs").subword(false)
			end)
			vim.keymap.set({ "o", "x" }, "iS", function()
				try_require("various-textobjs").subword(true)
			end)
		end,
	},

	-- 展示颜色
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			local r = try_require("text.color")
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
		event = "VeryLazy",
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

			del_cmd("TodoQuickFix")
			del_cmd("TodoTelescope")
			del_cmd("TodoTrouble")
			del_cmd("TodoLocList")

			cmd("command! -nargs=* Todo Telescope todo-comments todo <args>")
		end,
	},

	-- 长按j k 加速
	-- 卡顿
	{
		"rainbowhxch/accelerated-jk.nvim",
		event = "VeryLazy",
		config = function()
			vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
			vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
		end,
	},

	{
		"edte/normal-colon.nvim",
		event = "VeryLazy",
		-- opts = {},
		config = function()
			require("normal-colon").setup()
		end,
	},

	-- 轻松添加/更改/删除周围的分隔符对。用Lua ❤️ 编写。
	--add:    ys{motion}{char},
	--delete: ds{char},
	--change: cs{target}{replacement},

	--     Old text                    Command         New text
	-- --------------------------------------------------------------------------------
	--     surr*ound_words             ysiw)           (surround_words)
	--     *make strings               ys$"            "make strings"
	--     [delete ar*ound me!]        ds]             delete around me!
	--     remove <b>HTML t*ags</b>    dst             remove HTML tags
	--     'change quot*es'            cs'"            "change quotes"
	--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
	--     delete(functi*on calls)     dsf             function calls

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			try_require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- gx 打开 URL
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		-- you can specify also another config if you want
		config = function()
			try_require("gx").setup({
				open_browser_app = "open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
				open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
				handlers = {
					plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
					github = true, -- open github issues
					brewfile = true, -- open Homebrew formulaes and casks
					package_json = true, -- open dependencies from package.json
					search = true, -- search the web/selection on the web if nothing else is found
				},
				handler_options = {
					search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
					-- search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
				},
			})
		end,
	},

	-- ----------------------------------------------------------cmp--------------------------------------------------------------------------------------------------

	-- TabNine ai 补全
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
		event = "BufRead",
	},

	-- 单词补全
	{
		"uga-rosa/cmp-dictionary",
		event = "BufRead",
	},

	-- 计算器
	{
		"hrsh7th/cmp-calc",
		event = "BufRead",
	},

	-- nvim-cmp 表情符号源
	-- : 冒号触发
	{
		"hrsh7th/cmp-emoji",
		event = "BufRead",
	},

	-- nvim lua 的 nvim-cmp 源
	{
		"hrsh7th/cmp-nvim-lua",
		event = "BufRead",
	},

	{
		"tzachar/cmp-fuzzy-path",
		event = "BufRead",
		dependencies = { "tzachar/fuzzy.nvim" },
	},
	{
		"tzachar/cmp-fuzzy-buffer",
		event = "BufRead",
		dependencies = { "tzachar/fuzzy.nvim" },
	},

	-- {
	-- 	"tzachar/cmp-ai",
	-- event = "BufRead",
	-- 	dependencies = "nvim-lua/plenary.nvim",
	-- },

	-- 一个 Neovim 插件，用于将 vscode 风格的 TailwindCSS 补全添加到 nvim-cmp
	-- {
	-- 	"roobert/tailwindcss-colorizer-cmp.nvim",
	-- 	event = "VeryLazy",
	-- 	-- optionally, override the default options:
	-- 	config = function()
	-- 		try_require("tailwindcss-colorizer-cmp").setup({
	-- 			color_square_width = 2,
	-- 		})

	-- 		lvim.builtin.cmp.formatting = {
	-- 			format = require("tailwindcss-colorizer-cmp").formatter,
	-- 		}
	-- 	end,
	-- },

	-- nvim-cmp 的一个小函数，可以更好地对以一个或多个下划线开头的完成项进行排序。
	-- 在大多数语言中，尤其是 Python，以一个或多个下划线开头的项目应位于完成建议的末尾。
	-- { "lukas-reineke/cmp-under-comparator" },

	-- nvim-cmp 源代码用于显示强调当前参数的函数签名：
	-- {
	-- 	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- },

	-- {
	-- 	"hrsh7th/cmp-omni",
	-- 	event = "VeryLazy",
	-- },

	-- -- nvim-cmp 的拼写源基于 vim 的拼写建议。
	-- {
	-- 	"f3fora/cmp-spell",
	-- 	config = function()
	-- 		vim.opt.spell = true
	-- 		vim.opt.spelllang:append("en_us")
	-- 	end,
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"andersevenrud/cmp-tmux",
	-- },

	-- {
	-- 	"petertriho/cmp-git",
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = { "tzachar/cmp-ai" },
	-- },

	-- lsp 输入法
	-- {
	-- 	"liubianshi/cmp-lsp-rimels",
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"hrsh7th/nvim-cmp",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 	},
	-- 	config = function()
	-- 		require("rimels").setup({
	-- 			shared_data_dir = "/Library/Input Methods/Squirrel.app/Contents/SharedSupport", -- MacOS: /Library/Input Methods/Squirrel.app/Contents/SharedSupport
	-- 		})
	-- 	end,
	-- },

	-------------------------------------------------------代码补全相关------------------------------------------------------------------------------------------

	-- Clanalphagd 针对 neovim 的 LSP 客户端的不合规范的功能。使用 https://sr.ht/~p00f/clangd_extensions.nvim 代替
	{
		"p00f/clangd_extensions.nvim",
		event = "BufRead *.cpp",
	},

	-- wilder.nvim 插件，用于命令行补全，和 noice.nvim 冲突
	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter", -- 懒加载：首次进入cmdline时载入
		config = try_require("components.wilder").wilderFunc,
	},

	-- {
	-- 	"saecki/crates.nvim",
	-- 	event = { "BufRead Cargo.toml" },
	-- 	config = function()
	-- 		try_require("crates").setup()
	-- 	end,
	-- },

	-- 语言字典补全
	{
		"skywind3000/vim-dict",
		event = "VeryLazy",
	},

	{
		"edte/copilot",
		event = "VeryLazy",
	},

	-- {
	-- 	"edte/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },

	---------------------------------------------其他---------------------------------------------------------------------------------------------------------
	-- fzf 搜索
	-- 第一个别删
	{ "junegunn/fzf" },
	{ "junegunn/fzf.vim" },

	-- -------------------------------------------------------------语言相关---------------------------------------------------------------------------------------

	-- 键入时出现 LSP 签名提示
	{
		"ray-x/lsp_signature.nvim",
		event = "bufread",
		config = function()
			try_require("lsp_signature").on_attach()
		end,
	},

	-- lsp_lines 是一个简单的 neovim 插件，它使用真实代码行之上的虚拟行来呈现诊断。
	--https://git.sr.ht/~whynothugo/lsp_lines.nvim
	{
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
				update_in_insert = true,
				virtual_lines = {
					-- only_current_line = true,
					highlight_whole_line = false,
				},
			})
			require("lsp_lines").setup()
			vim.keymap.set("n", "g?", vim.diagnostic.open_float, { silent = true })
		end,
	},

	-- jce 高亮
	{
		"edte/jce-highlight",
		event = "BufRead *.jce",
		ft = { "jce" },
	},

	-- -- go 接口插件
	-- {
	-- 	"edolphin-ydf/goimpl.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-lua/popup.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 		{ "nvim-treesitter/nvim-treesitter" },
	-- 	},
	-- 	config = function()
	-- 		local r = try_require("code.go")
	-- 		if r ~= nil then
	-- 			r.implConfig()
	-- 		end
	-- 	end,
	-- },

	-- go 插件
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local r = try_require("code.go")
			if r ~= nil then
				r.goConfig()
			end
		end,

		event = "BufRead *.go",
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	-- Neovim 中人类可读的内联 cron 表达式
	{
		"fabridamicelli/cronex.nvim",
		opts = {},
		event = "BufRead *.go",
		config = function()
			local r = try_require("text.cron")
			if r ~= nil then
				r.cronConfig()
			end
		end,
	},

	-- 翻译插件
	{
		"voldikss/vim-translator",
		event = "VeryLazy",
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

	-- ---------------------------------------------------------------- git ---------------------------------------------------------------------------------
	-- 单选项卡界面可轻松循环浏览任何 git rev 的所有修改文件的差异。
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			local r = try_require("code.git")
			if r ~= nil then
				r.diffConfig()
			end
		end,
	},

	-- Neovim 中可视化和解决合并冲突的插件
	-- GitConflictChooseOurs — 选择当前更改。
	-- GitConflictChooseTheirs — 选择传入的更改。
	-- GitConflictChooseBoth — 选择两项更改。
	-- GitConflictChooseNone — 不选择任何更改。
	-- GitConflictNextConflict — 移至下一个冲突。
	-- GitConflictPrevConflict — 移至上一个冲突。
	-- GitConflictListQf — 将所有冲突获取到快速修复

	-- c o — 选择我们的
	-- c t — 选择他们的
	-- c b — 选择两者
	-- c 0 — 不选择
	-- ] x — 移至上一个冲突
	-- [ x — 移至下一个冲突
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		event = "VeryLazy",
	},
	-- normal mode提供Git/G 命令
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},

	-----------------------------------------treesitter -----------------------------------------------------------------------------------------------
	-- 显示代码上下文,包含函数签名
	-- barbucue 的补充，显示更多
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-telescope/telescope-project.nvim",
			"nvim-treesitter/nvim-treesitter-refactor",
		},
		config = function()
			local r = try_require("text.jump")
			if r ~= nil then
				r.contextConfig()
			end
			local n = try_require("code.highlight")
			if n ~= nil then
				n.highlightConfig()
			end
			local m = try_require("text.search")
			if m ~= nil then
				m.searchConfig()
			end
		end,
	},

	{
		"theHamsta/nvim-treesitter-pairs",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				pairs = {
					enable = true,
					disable = {},
					highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
					highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
					goto_right_end = false, -- whether to go to the end of the right partner or the beginning
					fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
					keymaps = {
						goto_partner = "<leader>%",
						delete_balanced = "X",
					},
					delete_balanced = {
						only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
						fallback_cmd_normal = nil, -- fallback command when no pair found, can be nil
						longest_partner = false, -- whether to delete the longest or the shortest pair when multiple found.
						-- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
					},
				},
			})
		end,
	},

	-- 语法感知文本对象、选择、移动、交换和查看支持。
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local r = try_require("text.jump")
			if r ~= nil then
				r.textConfig()
			end
		end,
	},

	-- 文本对象增强
	{
		"RRethy/nvim-treesitter-textsubjects",
		lazy = true,
		event = { "User FileOpened" },
		after = "nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local r = try_require("text.jump")
			if r ~= nil then
				r.textsubjectsConfig()
			end
		end,
	},

	-- -- 使用treesitter自动关闭并自动重命名html标签
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		config = function()
			try_require("nvim-ts-autotag").setup()
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

	-- Neovim 插件添加了对使用内置 LSP 的文件操作的支持
	{
		"antosha417/nvim-lsp-file-operations",
		event = "BufRead *.vue",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()

			local lspconfig = require("lspconfig")
			lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					--     -- returns configured operations if setup() was already called
					--     -- or default operations if not
					require("lsp-file-operations").default_capabilities()
				),
			})
		end,
	},

	{
		"echasnovski/mini.files",
		version = false,
		opts = {
			options = {
				use_as_default_explorer = false,
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
	},

	{
		"MeanderingProgrammer/markdown.nvim",
		event = "BufRead *.md",
		main = "render-markdown",
		ft = { "md" },
		opts = {
			file_types = { "markdown" },
		},
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	},

	-- 显示图片，和markdown.nvim一起使用，但是现在和tmux不兼容，切不同窗口图片都还在，故先注释掉
	-- -- lazy snippet
	-- {
	-- 	"3rd/image.nvim",
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

	-- 一个 neovim 插件，可预览应用了 LSP 代码操作的代码。
	-- {
	-- 	"aznhe21/actions-preview.nvim",
	-- 	config = function()
	-- 		vim.keymap.set({ "v", "n" }, "gp", require("actions-preview").code_actions)
	-- 	end,
	-- 	event = "BufRead *.go",
	-- },

	-- Fidget 是编辑器角落里的一个非侵入式窗口，可以管理自己的生命周期。其目标是：
	-- 为 Neovim 的 $/progress 处理程序提供 UI
	-- 提供可配置的 vim.notify() 后端
	-- 支持基本的 ASCII 动画（指尖陀螺！）以指示生命迹象
	-- 易于配置、易于维护且易于破解
	-- 状态行中只能存储这么多信息。此外，谁不喜欢一点终端视觉糖果作为款待呢？
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},

	-- 上下文感知悬停提供程序的通用框架（类似于 vim.lsp.buf.hover ）。
	-- 需要 Nvim v0.10.0
	{
		"lewis6991/hover.nvim",
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					-- require('hover.providers.gh')
					-- require('hover.providers.gh_user')
					-- require('hover.providers.jira')
					-- require('hover.providers.dap')
					-- require('hover.providers.fold_preview')
					-- require('hover.providers.diagnostic')
					-- require('hover.providers.man')
					-- require('hover.providers.dictionary')
				end,
				preview_opts = {
					border = "single",
				},
				--             -- Whether the contents of a currently open hover window should be moved
				--             -- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
				mouse_providers = {
					"LSP",
				},
				mouse_delay = 1000,
			})

			-- Setup keymaps
			vim.keymap.set("n", "K", function()
				local api = vim.api
				local hover_win = vim.b.hover_preview
				if hover_win and api.nvim_win_is_valid(hover_win) then
					api.nvim_set_current_win(hover_win)
				else
					require("hover").hover()
				end
			end, { desc = "hover.nvim" })
			vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
			-- vim.keymap.set("n", "<C-p>", function()
			-- 	require("hover").hover_switch("previous")
			-- end, { desc = "hover.nvim (previous source)" })
			-- vim.keymap.set("n", "<C-n>", function()
			-- 	require("hover").hover_switch("next")
			-- end, { desc = "hover.nvim (next source)" })

			-- Mouse support
			vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
			vim.o.mousemoveevent = true
		end,
	},

	-- Neovim 插件，用于显示 JB 的 IDEA 等函数的引用和定义信息。
	{
		"VidocqH/lsp-lens.nvim",
		event = "VeryLazy",
		-- target_symbol_kinds = {
		-- enable = true,
		-- include_declaration = true, -- Reference include declaration
		-- sections = { -- Enable / Disable specific request, formatter example looks 'Format Requests'
		-- 	definition = true,
		-- 	references = true,
		-- 	implements = true,
		-- 	git_authors = true,
		-- },
		-- vim.lsp.protocol.SymbolKind.Function,
		-- vim.lsp.protocol.SymbolKind.Method,
		-- vim.lsp.protocol.SymbolKind.Interface,
		-- vim.lsp.protocol.SymbolKind.Class,
		-- vim.lsp.protocol.SymbolKind.Struct, -- This is what you need
		-- },
		config = function()
			require("lsp-lens").setup({
				sections = {
					definition = function(count)
						return "Definitions: " .. count
					end,
					references = function(count)
						return "References: " .. count
					end,
					implements = function(count)
						return "Implements: " .. count
					end,
					git_authors = function(latest_author, count)
						return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
					end,
				},
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		event = "BufRead *.lua",
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	-- 上下文语法补全
	{
		"ray-x/cmp-treesitter",
		config = function()
			local r = try_require("code.completion")
			if r ~= nil then
				r.cmpConfig()
			end

			local m = try_require("code.lsp")
			if m ~= nil then
				m.lspConfig()
			end

			local n = try_require("code.format")
			if n ~= nil then
				n.formatConfig()
			end
		end,
	},
}
