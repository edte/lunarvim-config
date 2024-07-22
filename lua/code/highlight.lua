local M = {}

function M.highlightConfig()
	-- -- 进入 buffer 时，如果缺失了 parser,则自动下载
	lvim.builtin.treesitter.auto_install = true

	-- --
	lvim.lsp.installer.setup.automatic_servers_installation = true

	lvim.builtin.treesitter.highlight.enabled = true
	lvim.builtin.treesitter.ensure_installed = {
		"bash",
		"c",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"tsx",
		"css",
		"rust",
		"java",
		"yaml",
		"go",
		"cpp",
		"vue",
		"bash",
	}

	local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang
	require("nvim-treesitter.parsers").ft_to_lang = function(ft)
		if ft == "zsh" then
			return "bash"
		end
		return ft_to_lang(ft)
	end

	require("nvim-treesitter.parsers").filetype_to_parsername.zsh = "bash"
	vim.treesitter.language.register("bash", "zsh")
end

return M
