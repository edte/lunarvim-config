local M = {}

M.list = {}

require("code.format").formatConfig()
require("code.highlight").highlightConfig()
require("code.refactor").config()

return M
