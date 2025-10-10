do
	local enabled = true

	local inactive_bg = "#4f4f69"
	local cursorline_bg = "#5e5e6b"
	local ignore_filetypes = { "TelescopePrompt", "neo-tree", "NvimTree", "Outline", "starter" }

	local function is_floating(win)
		local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
		if not ok or not cfg then
			return false
		end
		return cfg.relative and cfg.relative ~= ""
	end

	local function should_ignore(win)
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_buf_get_option(buf, "filetype")
		local bt = vim.api.nvim_buf_get_option(buf, "buftype")
		if bt ~= "" and bt ~= "acwrite" then
			return true
		end
		for _, v in ipairs(ignore_filetypes) do
			if v == ft then
				return true
			end
		end
		return false
	end

	local function setup_highlights()
		vim.o.termguicolors = true
		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		pcall(vim.api.nvim_set_hl, 0, "NormalNC", { bg = inactive_bg })
		pcall(vim.api.nvim_set_hl, 0, "CursorLineNC", { bg = cursorline_bg })
	end

	local function update_winhl()
		if not enabled then
			return
		end
		local cur = vim.api.nvim_get_current_win()
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			if not is_floating(w) then
				if w == cur or should_ignore(w) then
					pcall(vim.api.nvim_win_set_option, w, "winhl", "")
				else
					pcall(vim.api.nvim_win_set_option, w, "winhl", "Normal:NormalNC,CursorLine:CursorLineNC")
				end
			end
		end
	end

	vim.api.nvim_create_user_command("DimInactiveToggle", function()
		enabled = not enabled
		if not enabled then
			for _, w in ipairs(vim.api.nvim_list_wins()) do
				pcall(vim.api.nvim_win_set_option, w, "winhl", "")
			end
			vim.notify("DimInactive: OFF", vim.log.levels.INFO)
		else
			update_winhl()
			vim.notify("DimInactive: ON", vim.log.levels.INFO)
		end
	end, {})

	-- autocommands to keep it in sync
	vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "WinNew", "VimResized", "BufLeave" }, {
		callback = function()
			vim.schedule(update_winhl)
		end,
	})
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			setup_highlights()
			vim.schedule(update_winhl)
		end,
	})

	-- initial setup
	setup_highlights()
	vim.schedule(update_winhl)
end
