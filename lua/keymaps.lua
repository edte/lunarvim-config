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

-- 保存文件
keymap("", "<C-s>", ":w<cr>")

-- 删除整行
keymap("", "D", "Vd")

keymap("n", "c", '"_c')

-- -- 设置 jj、jk 为 ESC,避免频繁按 esc
-- map("i", "jj", "<esc>", opt)
keymap("i", "jk", "<esc>")

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
keymap("n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>")

keymap("n", "<bs>", "<C-^>")

keymap("", "gd", "<cmd>Telescope lsp_definitions<cr>")
keymap("", "gD", "<cmd>FzfLua lsp_declarations<cr>")
keymap("", "gr", "<cmd>FzfLua lsp_references<cr>")

-- gd 跳转定义
-- gf 跳转函数头
-- gm 重命名

-- 交换 : ;

cmd("nnoremap ; :")
cmd("nnoremap : ;")

cmd("inoremap ; :")
cmd("inoremap : ;")

cmd("nnoremap <Enter> o<ESC>") -- Insert New Line quickly
-- cmd("nnoremap <Enter> %")

cmd("xnoremap p P")

cmd("silent!")

-- cmd("nnoremap # *")
-- cmd("nnoremap * #")

-- 当你在编辑 /a/b/c/d/e.txt 文件时，由于该文件父级目录的缺失会导致该文件无法写入磁盘。此时你只需要在 cmd 中输入上面定义的命令 :MakeDirectory 即可递归的创建一系列的缺失目录
create_cmd("MakeDirectory", function()
	---@diagnostic disable-next-line: missing-parameter
	local path = vim.fn.expand("%")
	local dir = vim.fn.fnamemodify(path, ":p:h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	else
		vim.notify("Directory already exists", "WARN", { title = "Nvim" })
	end
end, { desc = "Create directory if it doesn't exist" })

-- 如果你安装了诸如 neotree 或 nvim-tree 这种大纲性质的插件并且它们被打开时，那么你可能希望在当前缓冲区删除的时候不会影响到现有的窗口布局。上面的自动命令 BUfferDelete 很好的完成了这件事。所以，再见 bufdelete.nvim 插件，该命令灵感来源于 NvChad 的早期版本。
create_cmd("BufferDelete", function()
	---@diagnostic disable-next-line: missing-parameter
	local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
	local modified = vim.api.nvim_buf_get_option(0, "modified")
	if file_exists == 0 and modified then
		local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
		if user_choice == "y" or string.len(user_choice) == 0 then
			vim.cmd("bd!")
		end
		return
	end
	local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
	vim.cmd(force and "bd!" or string.format("bp | bd! %s", vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })

keymap("n", "gh", "<CMD>ClangdSwitchSourceHeader<CR>")

cmd("command! Pwd !ls %:p")
-- cmd("command! Pwd lua print(vim.fn.getcwd())")

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
