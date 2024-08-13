local M = {}

M.config = function()
	-- lvim.builtin.breadcrumbs.active                     = false
	vim.opt.termguicolors = true

	local buffer = try_require("bufferline")
	if buffer == nil then
		return
	end

	-- 删除buffer

	keymap("n", "<<", ":BufferLineMovePrev<cr>")
	keymap("n", ">>", ":BufferLineMoveNext<cr>")

	-- -- 移动左右 buffer
	keymap("n", "gn", ":BufferLineCycleNext<CR>")
	keymap("n", "gp", ":BufferLineCyclePrev<CR>")
end

return M
