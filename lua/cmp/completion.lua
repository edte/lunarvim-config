local M = {}

function M.cmpConfig()
	local cmp, compare = try_require("cmp"), try_require("cmp.config.compare")
	if cmp == nil then
		print("cmp == nil")
		return
	end
	if compare == nil then
		print("compare == nil")
		return
	end

	-- cmp 源
	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		completion = { completeopt = "menu,menuone,select" },

		sources = {
			{
				name = "nvim_lsp:rimels",
				priority = 8,
			},
			{
				name = "cmp_tabnine",
				priority = 8,
			},
			-- {
			-- 	name = "copilot",
			-- 	group_index = 2,
			-- 	priority = 8,
			-- },
			-- {
			-- 	name = "cmp_ai",
			-- 	priority = 8,
			-- },
			{
				name = "nvim_lsp",
				priority = 8,
			},
			-- {
			-- 	name = "nvim_lsp_signature_help",
			-- 	priority = 8,
			-- },
			{
				name = "luasnip",
				priority = 7,
			},
			{
				name = "buffer",
				priority = 7,
			},
			{
				name = "dictionary",
				priority = 6,
				keyword_length = 6,
				keyword_pattern = [[\w\+]],
			},

			{
				priority = 6,
				name = "treesitter",
			},

			-- {
			-- 	priority = 6,
			-- 	name = "tailwindcss-colorizer-cmp",
			-- },

			-- {
			-- 	name = "spell",
			-- 	priority = 6,
			-- 	keyword_length = 3,
			-- 	keyword_pattern = [[\w\+]],
			-- 	option = {
			-- 		keep_all_entries = false,
			-- 		enable_in_context = function()
			-- 			return true
			-- 		end,
			-- 	},
			-- },
			{
				name = "nvim_lua",
				priority = 5,
			},
			-- {
			-- 	name = "fuzzy_path",
			-- 	priority = 4,
			-- },
			-- {
			-- 	name = "fuzzy_buffer",
			-- 	priority = 4,
			-- },
			-- {
			--     name = "path",
			--     priority = 4
			-- },
			{
				name = "emoji",
				priority = 4,
			},
			-- {
			-- 	name = "calc",
			-- 	priority = 4,
			-- },
			-- {
			--     name = 'tmux',
			--     priority = 4
			-- },
			-- {
			--     name = "git",
			--     priority = 4
			-- },
			--
			-- {
			-- 	name = "omni",
			-- 	option = {
			-- 		disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
			-- 		priority = 4,
			-- 	},
			-- },
			-- {
			-- 	name = "fittencode",
			-- 	group_index = 1,
			-- 	priority = 4,
			-- },
		},

		-- cmp 补全的顺序
		-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
		sorting = {
			priority_weight = 1.0,
			comparators = {
				-- cmp.config.compare.offset, -- 偏移量较小的条目将排名较高
				-- cmp.config.compare.exact,  -- 具有精确== true的条目将排名更高
				-- cmp.config.compare.score,  -- 得分越高的作品排名越高
				-- try_require "cmp-under-comparator".under,
				-- cmp.config.compare.kind,  -- “kind”序数值较小的整体将排名较高
				-- cmp.config.compare.sort_text, -- 条目将按照 sortText 的字典顺序进行排名
				-- cmp.config.compare.length,  --条目，与较短的标签的长度将位居高
				-- cmp.config.compare.order, -- 项与小id将排名更高的
				-- compare.recently_used, --最近使用的条目将排名更高
				-- cmp.locality       --地点:项目与更高的地方(即，言语更接近于光标)将排名较高
				-- compare.scopes  -- 在更近的作用域中定义的条目排名会更高（例如，优先选择局部变量，而不是全局变量

				-- -- try_require("cmp.config.compare").sort_text, -- 这个放第一个, 其他的随意
				-- compare.exact,         -- 精准匹配
				-- compare.recently_used, -- 最近用过的靠前
				-- compare.kind,
				-- try_require("clangd_extensions.cmp_scores"),
				-- compare.score, -- 得分高靠前
				-- compare.order,
				-- compare.offset,
				-- compare.length, -- 短的靠前
				-- compare.sort_test,

				-- compare.score_offset, -- not good at all
				-- try_require('cmp_ai.compare'),
				compare.locality,
				compare.recently_used,
				compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
				-- try_require("copilot_cmp.comparators").prioritize,
				try_require("cmp_tabnine.compare"),
				compare.offset,
				compare.order,
				-- compare.scopes, -- what?
				-- compare.sort_text,
				-- compare.exact,
				-- compare.kind,
				-- compare.length, -- useless
				-- require("cmp-under-comparator").under,
			},
		},

		mapping = cmp.mapping.preset.insert({
			["<Space>"] = cmp.mapping(function(fallback)
				local entry = cmp.get_selected_entry()
				if entry == nil then
					entry = cmp.core.view:get_first_entry()
				end
				if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					})
				else
					fallback()
				end
			end, { "i", "s" }),
			["<CR>"] = cmp.mapping(function(fallback)
				local entry = cmp.get_selected_entry()
				if entry == nil then
					entry = cmp.core.view:get_first_entry()
				end
				if entry and entry.source.name == "nvim_lsp" and entry.source.source.client.name == "rime_ls" then
					print(entry.source.name)
					cmp.abort()
				else
					if entry ~= nil then
						cmp.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						})
					else
						fallback()
					end
				end
			end, { "i", "s" }),
		}),
	})

	-- 其他设置

	-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- 	underline = true,
	-- 	virtual_text = {
	-- 		spacing = 5,
	-- 		{ min = "Warning" },
	-- 		-- severity_limit = "Warning",
	-- 	},
	-- 	update_in_insert = true,
	-- })

	-- tabline 设置，一个ai补全的
	local tabnine = try_require("cmp_tabnine.config")
	if tabnine == nil then
		print("tabnine == nil")
		return
	end

	tabnine:setup({
		max_lines = 1000,
		max_num_results = 20,
		sort = true,
		run_on_every_keystroke = true,
		snippet_placeholder = "..",
		ignored_file_types = {
			-- default is not to ignore
			-- uncomment to ignore in lua:
			-- lua = true
		},
		show_prediction_strength = false,
		min_percent = 0,
	})

	-- 字典/单词补全设置
	local sources_table = lvim.builtin.cmp.sources
	sources_table[#sources_table + 1] = {
		name = "dictionary",
		keyword_length = 4,
	}
	-- sources_table[#sources_table + 1] = {
	-- 	name = "spell",
	-- }
	sources_table[#sources_table + 1] = {
		name = "fuzzy_path",
	}
	sources_table[#sources_table + 1] = {
		name = "fuzzy_buffer",
	}

	-- git clone https://github.com/skywind3000/vim-dict /Users/edte/.config/lvim/
	local dict = {
		["*"] = { "/usr/share/dict/words" },
		go = { "/Users/edte/.config/lvim/dict/go.dict" },
		sh = { "/Users/edte/.config/lvim/dict/sh.dict" },
		lua = { "/Users/edte/.config/lvim/dict/lua.dict" },
		html = { "/Users/edte/.config/lvim/dict/html.dict" },
		css = { "/Users/edte/.config/lvim/dict/css.dict" },
		cpp = { "/Users/edte/.config/lvim/dict/cpp.dict" },
		cmake = { "/Users/edte/.config/lvim/dict/cmake.dict" },
		c = { "/Users/edte/.config/lvim/dict/c.dict" },
	}

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function(ev)
			dict = try_require("cmp_dictionary")
			if dict == nil then
				print("dict == nil")
				return
			end
			dict.setup({
				paths = dict[ev.match] or dict["*"],
				exact_length = 4,
				first_case_insensitive = true,
			})
		end,
	})

	--
	-- try_require("cmp_git").setup()

	-- lvim.builtin.cmp.cmdline.enable = true

	-- openai
	-- local cmp_ai = try_require('cmp_ai.config')

	-- cmp_ai:setup({
	--     max_lines = 1000,
	--     provider = 'HF',
	--     notify = true,
	--     notify_callback = function(msg)
	--         vim.notify(msg)
	--     end,
	--     run_on_every_keystroke = true,
	--     ignored_file_types = {
	--         -- default is not to ignore
	--         -- uncomment to ignore in lua:
	--         -- lua = true
	--     },
	-- })
end

return M
