local M = {}

M.list = {
	-- lsp_lines 是一个简单的 neovim 插件，它使用真实代码行之上的虚拟行来呈现诊断。
	--https://git.sr.ht/~whynothugo/lsp_lines.nvim
	{
		-- url 备份
		-- url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		url = "https://github.com/edte/lsp_lines.nvim",
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

	-- 键入时出现 LSP 签名提示
	{
		"ray-x/lsp_signature.nvim",
		event = "bufread",
		config = function()
			try_require("lsp_signature").on_attach()
		end,
	},
	-- Clanalphagd 针对 neovim 的 LSP 客户端的不合规范的功能。使用 https://sr.ht/~p00f/clangd_extensions.nvim 代替
	{
		"p00f/clangd_extensions.nvim",
		ft = { "cpp", "h" },
	},

	-- jce 高亮
	{
		"edte/jce-highlight",
		ft = { "jce" },
	},

	-- -- go 接口插件
	-- {
	-- 	"edolphin-ydf/goimpl.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-lua/popup.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 	},
	-- 	config = function()
	-- 		local r = try_require("lsp.go")
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
		},
		config = function()
			local r = try_require("lsp.go")
			if r ~= nil then
				r.goConfig()
			end
		end,

		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	-- Neovim 插件添加了对使用内置 LSP 的文件操作的支持
	{
		"antosha417/nvim-lsp-file-operations",
		ft = { "vue" },
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

	-- 基于 Neovim 的命令预览功能的增量 LSP 重命名。
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = function()
			require("inc_rename").setup({})
		end,
	},

	-- 显示接口实现了哪些
	{
		"maxandron/goplements.nvim",
		ft = "go",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- Neovim 插件，用于显示 JB 的 IDEA 等函数的引用和定义信息。
	{
		"edte/lsp_lens.nvim",
		ft = { "lua", "go", "cpp" },
		config = function()
			local SymbolKind = vim.lsp.protocol.SymbolKind
			Setup("lsp-lens", {
				target_symbol_kinds = {
					SymbolKind.Function,
					SymbolKind.Method,
					SymbolKind.Interface,
					SymbolKind.Class,
					SymbolKind.Struct, -- This is what you need
				},
				indent_by_lsp = false,
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
					try_require("hover").hover()
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

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	-- 在分割窗口或弹出窗口中运行测试并提供实时反馈
	{
		"quolpr/quicktest.nvim",
		ft = "go",
		config = function()
			local qt = require("quicktest")

			qt.setup({
				-- Choose your adapter, here all supported adapters are listed
				adapters = {
					require("quicktest.adapters.golang")({
						additional_args = function(bufnr)
							return { "-race", "-count=1" }
						end,
						-- bin = function(bufnr) return 'go' end
						-- cwd = function(bufnr) return 'your-cwd' end
					}),
					require("quicktest.adapters.vitest")({
						-- bin = function(bufnr) return 'vitest' end
						-- cwd = function(bufnr) return bufnr end
						-- config_path = function(bufnr) return 'vitest.config.js' end
					}),
					require("quicktest.adapters.elixir"),
					require("quicktest.adapters.criterion"),
					require("quicktest.adapters.dart"),
				},
				-- split or popup mode, when argument not specified
				default_win_mode = "split",
				-- Baleia make coloured output. Requires baleia package. Can cause crashes https://github.com/quolpr/quicktest.nvim/issues/11
				use_baleia = false,
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- "m00qek/baleia.nvim",
		},
		keys = {
			{
				"tl",
				function()
					local qt = require("quicktest")
					-- current_win_mode return currently opened panel, split or popup
					qt.run_line()
					-- You can force open split or popup like this:
					-- qt.run_line('split')
					-- qt.run_line('popup')
				end,
				desc = "[T]est Run [L]line",
			},
			{
				"tt",
				function()
					local qt = require("quicktest")

					qt.toggle_win("split")
				end,
				desc = "[T]est [T]oggle Window",
			},
			{
				"tc",
				function()
					local qt = require("quicktest")

					qt.cancel_current_run()
				end,
				desc = "[T]est [C]ancel Current Run",
			},
		},
	},

	{
		"amitds1997/remote-nvim.nvim",
		version = "*", -- Pin to GitHub releases
		dependencies = {
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
	},
}

local m = try_require("lsp.lsp")
if m ~= nil then
	m.lspConfig()
end

return M
