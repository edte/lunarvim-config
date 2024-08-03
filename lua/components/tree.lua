-- nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- vim.g.loaded_netrw = true -- or 1
-- vim.g.loaded_netrwPlugin = true -- or 1

lvim.builtin.nvimtree.setup.disable_netrw = false

lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

function ToggleMiniFiles()
	local mf = require("mini.files")
	if not mf.close() then
		mf.open(vim.api.nvim_buf_get_name(0))
		mf.reveal_cwd()
	end
end

-- 火焰图排查
-- require'plenary.profile'.start("profile.log", {flame = true})
-- require'plenary.profile'.stop()
-- /Users/edte/go/src/test/FlameGraph/flamegraph.pl profile.log  > example.svg
