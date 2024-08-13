-- 使用 pcall 和 require 尝试加载包
function try_require(package_name)
	local status, plugin = pcall(require, package_name)
	if not status then
		-- 如果加载失败，打印错误信息
		print("require " .. plugin)
		return nil
	else
		-- 如果加载成功，返回包
		return plugin
	end
end

function Setup(package_name, options)
	-- 尝试加载包，捕获加载过程中的错误
	local success, package = pcall(require, package_name)

	if not success then
		-- 如果加载失败，打印错误信息
		print("Error loading package " .. package_name .. ": " .. package)
		return
	end

	-- 检查包是否具有 'setup' 函数
	if type(package.setup) ~= "function" then
		print("Error: package " .. package_name .. " does not have a 'setup' function")
		return
	end

	-- 调用包的 'setup' 函数进行设置
	package.setup(options)
end

local opt = {
	noremap = true,
	silent = true,
}

function keymap(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
end

Create_cmd = vim.api.nvim_create_user_command

cmd = vim.cmd

Autocmd = vim.api.nvim_create_autocmd

Del_cmd = vim.api.nvim_del_user_command
