-- =================================================vim option settings=======================================================
-- 设置 vim 的剪切板与系统公用
vim.opt.clipboard = "unnamedplus"

vim.g.have_nerd_font = true

vim.opt.mouse = "a"

--=================================================luvar_vim general settings==============================================================
-- 日志等级
lvim.log.level = "error"

-- lvim.log.level = "trace"
-- vim.lsp.set_log_level("trace")

-- 不可见字符的显示，这里只把空格显示为一个点
-- vim.o.list = false
-- vim.o.listchars = "space:·"

-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.hidden = true

-- -- 恢复上次会话
-- vim.opt.sessionoptions = 'buffers,curdir,tabpages,winsize'

-- -- tab 的空格数
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.o.scrolloff = 0
