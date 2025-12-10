local M = {}

function M.current()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return ""
	end

	local buf = vim.api.nvim_get_current_buf()
	local formatters = conform.list_formatters(buf)

	if not formatters or #formatters == 0 then
		return ""
	end

	-- For example: " prettier"
	return "  " .. formatters[1].name
end

return M
