-- 自动切换cwd（项目维度），方便各种插件使用，比如bookmark，arrow，telescope等等，
-- 包括 git，makefile，lsp根目录，兼容普通目录，即进入的那个目录
require("vim.cwd").setup()

-- 存储模块名称的表
local modules = {
	"bookmark.plugins",
	"cmp.plugins",
	"code.plugins",
	"components.plugins",
	"git.plugins",
	"lsp.plugins",
	"text.plugins",
	"ui.plugins",
	"vim.plugins",
}

-- 遍历每个模块
for _, module_name in ipairs(modules) do
	local module = try_require(module_name)
	if module == nil then
		return
	end
	-- 遍历模块中的每个插件
	for _, plugin in ipairs(module.list) do
		table.insert(lvim.plugins, plugin)
	end
end
