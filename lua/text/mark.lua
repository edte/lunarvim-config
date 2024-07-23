local M = {}

M.marksConfig = function()
	local mark = try_require("marks")
	if mark == nil then
		return
	end

	mark.setup({
		-- whether to map keybinds or not. default true
		default_mappings = true,
		-- which builtin marks to show. default {}
		builtin_marks = { ".", "<", ">", "^" },
		-- whether movements cycle back to the beginning/end of buffer. default true
		cyclic = true,
		-- whether the shada file is updated after modifying uppercase marks. default false
		force_write_shada = false,
		-- how often (in ms) to redraw signs/recompute mark positions.
		-- higher values will have better performance but may cause visual lag,
		-- while lower values may cause performance penalties. default 150.
		refresh_interval = 250,
		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- disables mark tracking for specific filetypes. default {}
		excluded_filetypes = {},
		-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
		-- sign/virttext. Bookmarks can be used to group together positions and quickly move
		-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
		-- default virt_text is "".
		bookmark_0 = {
			sign = "⚑",
			virt_text = "hello world",
			-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
			-- defaults to false.
			annotate = false,
		},
		mappings = {
			set_next = "mm",
			delete_line = "md",
			delete_buf = "mD",
			-- next = "m,",
			-- prev = "m.",
			-- preview = "m:",
		},
	})
end

-- Use lowercase for global marks and uppercase for local marks.
local low = function(i)
	return string.char(97 + i)
end
local upp = function(i)
	return string.char(65 + i)
end

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

return M
