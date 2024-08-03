local M = {}

M.treesjConfig = function()
	local treesj = try_require("treesj")
	if treesj == nil then
		return
	end
	treesj.setup({})

	vim.api.nvim_create_user_command("Toggle", function()
		require("treesj").toggle({ split = { recursive = true } })
	end, {})

	-- keymap("n", "K", "<cmd>Toggle<cr>")
end
return M
