lvim.builtin.bufferline.active = false

vim.opt.termguicolors = true
local buffer = try_require("bufferline")
if buffer == nil then
	return
end

-- 删除buffer

lvim.builtin.which_key.mappings["C"] = {
	":BufferCloseAllButCurrent<cr>",
	"close other buffers",
}

-- lvim.builtin.which_key.mappings["c"] = {
-- 	":BufferKill<cr>",
-- 	"close other buffers",
-- }

keymap("n", "<<", ":BufferMovePrevious<cr>")
keymap("n", ">>", ":BufferMoveNext<cr>")

-- keymap("n", "c", ":bd<CR>")

-- -- 移动左右 buffer
keymap("n", "gn", ":BufferNext<CR>")
keymap("n", "gp", ":BufferPrevious<CR>")
