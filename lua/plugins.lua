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
