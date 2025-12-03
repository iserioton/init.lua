local M = {}

-- return true if project has an eslint config
function M.has_config(buf)
	local filename = vim.api.nvim_buf_get_name(buf)
	return vim.fs.find({
		".eslintrc",
		".eslintrc.json",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
	}, { upward = true, path = filename })[1] ~= nil
end

function M.default_rules()
	return {
		workingDirectory = { mode = "auto" },
		format = false,
		rulesCustomizations = {
			-- BEST PRACTICES
			{ rule = "no-unused-vars", severity = "warn", ruleValue = { args = "after-used", vars = "all" } },
			{ rule = "no-undef", severity = "error" },
			{ rule = "no-empty", severity = "error" },
			{ rule = "no-console", severity = "warn" },
			{ rule = "no-var", severity = "error" },
			{ rule = "prefer-const", severity = "warn" },

			-- STYLE (MATCH PRETTIER)
			{ rule = "semi", severity = "error", ruleValue = "always" }, -- no semicolons
			{ rule = "quotes", severity = "warn", ruleValue = "single" }, -- single quotes
			{ rule = "comma-dangle", severity = "warn", ruleValue = "always-multiline" }, -- trailing comma
			{ rule = "arrow-parens", severity = "off" }, -- avoid parens for single param
			{ rule = "indent", severity = "off" }, -- Prettier handles indentation

			-- EQUALITY
			{ rule = "eqeqeq", severity = "error", ruleValue = "always" },

			-- CURLY BRACES
			{ rule = "curly", severity = "warn", ruleValue = "multi-line" },
		},
	}
end

return M
