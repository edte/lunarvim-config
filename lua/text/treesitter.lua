local M = {}
M.config = function()
	vim.g.skip_ts_context_commentstring_module = true
	lvim.builtin.treesitter.matchup.enable = true
	lvim.builtin.telescope.theme = "center"

	local config = try_require("nvim-treesitter.configs")
	if config == nil then
		return
	end

	config.setup({
		highlight = {
			enable = true,
			language_tree = true,
			is_supported = function()
				-- Since `ibhagwan/fzf-lua` returns `bufnr/path` like `117/lua/plugins/colors.lua`.
				local cur_path = (vim.fn.expand("%"):gsub("^%d+/", ""))
				if
					cur_path:match("term://")
					or vim.fn.getfsize(cur_path) > 1024 * 1024 -- file size > 1 MB.
					or vim.fn.strwidth(vim.fn.getline(".")) > 300 -- width > 300 chars.
				then
					return false
				end
				return true
			end,
		},
		refactor = {
			-- 高亮显示光标下当前符号的定义和用法。
			highlight_definitions = {
				enable = true,
				-- Set to false if you have an `updatetime` of ~100.
				clear_on_cursor_move = true,
			},

			-- 强调块从目前的范围在哪里的光标。
			-- highlight_current_scope = { enable = true },

			-- 重命名当前作用域（和当前文件）内光标下的符号。
			smart_rename = {
				enable = true,
				-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
				keymaps = {
					-- smart_rename = "gm",
					-- smart_rename = false,
				},
			},

			-- 为光标下的符号提供 "转到定义"，并列出当前文件中的定义。
			-- 如果 nvim-treesitter 无法解析变量，则使用 vim.lsp.buf.definition 代替下面配置中的 goto_definition_lsp_fallback。
			-- goto_next_usage/goto_previous_usage 将转到光标下标识符的下一个用法。
			navigation = {
				enable = true,
				-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
				keymaps = {
					goto_definition = false,
					list_definitions = false,
					list_definitions_toc = false,
					goto_next_usage = false,
					goto_previous_usage = false,
				},
			},
		},
		textsubjects = {
			enable = true,
			prev_selection = ",",
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
				["i;"] = "textsubjects-container-inner",
			},
		},
		-- -- gf 跳函数开头
		-- textobjects = {
		-- 	move = {
		-- 		enable = true,
		-- 		set_jumps = true,
		-- 		goto_previous_start = {
		-- 			["gf"] = { query = { "@function.outer" } },
		-- 		},
		-- 	},
		-- },
		matchup = {
			enable = true, -- mandatory, false will disable the whole extension
		},

		-- pair
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

	local context = try_require("treesitter-context")
	if context == nil then
		return
	end
	context.setup({
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 1, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 1, -- Maximum number of lines to show for a single context
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 1, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	})

	-- 跳转到上下文（向上）
	vim.keymap.set("n", "gc", function()
		require("treesitter-context").go_to_context(vim.v.count1)
	end, { silent = true })
end

return M
