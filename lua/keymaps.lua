-- --==========================================luvar_vim keybinding settings===============================================================
-- 取消lunar的一些默认快捷键
lvim.keys.insert_mode["<A-j>"] = false
lvim.keys.insert_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.visual_block_mode["<A-j>"] = false
lvim.keys.visual_block_mode["<A-k>"] = false
lvim.keys.visual_block_mode["J"] = false
lvim.keys.visual_block_mode["K"] = false

vim.keymap.del("", "grr", {})
vim.keymap.del("", "gra", {})
vim.keymap.del("", "grn", {})

-- vim.cmd("nmap <tab> %")

-- -- 上下滚动浏览
keymap("", "<C-j>", "5j")
keymap("", "<C-k>", "5k")

-- 保存文件
keymap("", "<C-s>", ":w<cr>")

-- 删除整行
keymap("", "D", "Vd")

keymap("n", "c", '"_c')

-- -- 设置 jj、jk 为 ESC,避免频繁按 esc
-- map("i", "jj", "<esc>", opt)
keymap("i", "jk", "<esc>")

-- 按 esc 消除上一次的高亮
keymap("n", "<esc>", ":noh<cr>")

vim.keymap.set("n", "<esc>", function()
	cmd(":nohlsearch")
	cmd(":call clever_f#reset()")
end, { desc = "esc", noremap = true, buffer = true })

-- 大小写转换
-- map("n", "<esc>", "~", opt)

-- what?
-- map("n", "<cmd>lua vim.lsp.buf.hover()<cr>", opt)

keymap("n", "yp", 'vi"p')
keymap("n", "vp", 'vi"p')

----------------------------------------------------------------
-- 取消撤销
keymap("n", "U", "<c-r>")

-- error 管理
keymap("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- pre error
keymap("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>") -- next error

-- 查看文档
-- keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- 重命名
-- keymap("n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>")

vim.keymap.set("n", "R", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

keymap("n", "<bs>", "<C-^>")
keymap("", "gI", ":Glance implementations<cr>")
keymap("", "gd", "<cmd>Telescope lsp_definitions<cr>")
keymap("", "gD", "<cmd>FzfLua lsp_declarations<cr>")
keymap("", "gr", "<cmd>Glance references<cr>")
keymap("n", "gh", "<CMD>ClangdSwitchSourceHeader<CR>")

keymap("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- pre error
keymap("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>") -- next error

--------------------------------------------------------------screen ------------------------------------------------
------------------------------------------------------------------
--                          分屏
------------------------------------------------------------------
keymap("n", "s", "") -- 取消 s 默认功能
-- map("n", "S", "", opt)                          -- 取消 s 默认功能

-- 分屏状态下，一起滚动，用于简单的diff
-- set scrollbind
-- 恢复
-- set noscrollbind

keymap("n", "sv", ":vsp<CR>") -- 水平分屏
keymap("n", "sh", ":sp<CR>") -- 垂直分屏

keymap("n", "sc", "<C-w>c") -- 关闭当前屏幕
keymap("n", "so", "<C-w>o") -- 关闭其它屏幕

keymap("n", "s,", ":vertical resize +20<CR>") -- 向右移动屏幕
keymap("n", "s.", ":vertical resize -20<CR>") -- 向左移动屏幕

keymap("n", "sm", "<C-w>|") -- 全屏
keymap("n", "sn", "<C-w>=") -- 恢复全屏

keymap("n", "<a-,>", "<C-w>h") -- 移动到左分屏
keymap("n", "<a-.>", "<C-w>l") -- 移动到右分屏

-- 窗口切换
keymap("n", "<left>", "<c-w>h")
keymap("n", "<right>", "<c-w>l")
keymap("n", "<up>", "<c-w>k")
keymap("n", "<down>", "<c-w>j")
keymap("", "<c-h>", "<c-w>h")
keymap("", "<c-l>", "<c-w>l")

---------------------------------------------------------------------mark -------------------

-- Use lowercase for global marks and uppercase for local marks.
local low = function(i)
	return string.char(97 + i)
end
local upp = function(i)
	return string.char(65 + i)
end

-- 所有vim自带的mark都默认为大写
for i = 0, 25 do
	vim.keymap.set("n", "m" .. low(i), "m" .. upp(i))
end
for i = 0, 25 do
	vim.keymap.set("n", "m" .. upp(i), "m" .. low(i))
end
for i = 0, 25 do
	vim.keymap.set("n", "'" .. low(i), "'" .. upp(i))
end
for i = 0, 25 do
	vim.keymap.set("n", "'" .. upp(i), "'" .. low(i))
end

----------------------------------------------------------------which key ------------------------------------------------------------------------
-- leader 键

local utils = require("telescope.utils")
_G.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		require("fzf-lua").git_files()
	else
		require("fzf-lua").files()
	end
end

lvim.leader = "space"

lvim.builtin.which_key.vmappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	},
	g = {
		name = "Git",
		r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
		s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
	},
	t = { ":'<,'>Translate ZH<cr>", "Translate" },
}

lvim.builtin.which_key.mappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_current)", "comment" },
	["q"] = { "<cmd>confirm q<CR>", "quit" },
	["c"] = { "<cmd>bd<CR>", "close Buffer" },
	["C"] = { "<cmd>BufferLineCloseOthers<CR>", "Close Other Buffer" },
	["e"] = { "<cmd>lua ToggleMiniFiles()<CR>", "Explorer" },
	["t"] = { "<cmd>FzfLua live_grep_native<CR>", "text" },
	["f"] = { "<cmd>lua project_files()<CR>", "files" },
	["r"] = { "<cmd>Telescope oldfiles<CR>", "recents" },

	p = {
		name = "plugins",
		i = { "<cmd>Lazy install<cr>", "Install" },
		s = { "<cmd>Lazy sync<cr>", "Sync" },
		S = { "<cmd>Lazy clear<cr>", "Status" },
		c = { "<cmd>Lazy clean<cr>", "Clean" },
		u = { "<cmd>Lazy update<cr>", "Update" },
		p = { "<cmd>Lazy profile<cr>", "Profile" },
		l = { "<cmd>Lazy log<cr>", "Log" },
		d = { "<cmd>Lazy debug<cr>", "Debug" },
	},

	g = {
		name = "git",
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "blame" },
		s = { "<cmd>FzfLua git_status<cr>", "status" },
		b = { "<cmd>FzfLua git_branches<cr>", "branch" },
		c = { "<cmd>FzfLua git_commits<cr>", "commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"diff",
		},
	},

	l = {
		name = "lsp",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Mason Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<cr>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	},

	L = {
		name = "LunarVim",
		c = {
			"<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
			"Edit config.lua",
		},
		d = { "<cmd>LvimDocs<cr>", "View LunarVim's docs" },
		f = {
			"<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
			"Find LunarVim files",
		},
		g = {
			"<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
			"Grep LunarVim files",
		},
		k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
		i = {
			"<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
			"Toggle LunarVim Info",
		},
		I = {
			"<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
			"View LunarVim's changelog",
		},
		l = {
			name = "+logs",
			d = {
				"<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
				"view default log",
			},
			D = {
				"<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
				"Open the default logfile",
			},
			l = {
				"<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
				"view lsp log",
			},
			L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
			n = {
				"<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
				"view neovim log",
			},
			N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
		},
		r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
		u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
	},

	s = {
		name = "search",
		a = { "<cmd>FzfLua autocmds<cr>", "autocmds" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		k = { "<cmd>FzfLua keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	},
}
