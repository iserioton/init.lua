function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			ColorMyPencils()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
						refresh_time = 16, -- ~60fps
						events = {
							"WinEnter",
							"BufEnter",
							"BufWritePost",
							"SessionLoadPost",
							"FileChangedShellPost",
							"VimResized",
							"Filetype",
							"CursorMoved",
							"CursorMovedI",
							"ModeChanged",
						},
					},
				},
				sections = {
					lualine_a = { { "mode", icons_enabled = true } },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"buffers",
							show_filename_only = true,
							hide_filename_extension = false,
							show_modified_status = false,
							mode = 2,
							max_length = vim.o.columns * 2 / 3,
							use_mode_colors = true,
							filetype_names = {
								TelescopePrompt = "Telescope",
								dashboard = "Dashboard",
								packer = "Packer",
								fzf = "FZF",
								alpha = "Alpha",
							},
							buffers_color = {
								active = { fg = "#89b4fa", gui = "bold" },
								inactive = { fg = "#6c7086" },
							},
							symbols = {
								modified = " ●",
								alternate_file = "#",
								directory = "",
							},
						},
					},
					lualine_x = {
						{
							"filename",
							file_status = true,
							newfile_status = false,
							path = 0,
							shorting_target = 40,
							symbols = {
								modified = "[+]",
								readonly = "[-]",
								unnamed = "[No Name]",
								newfile = "[New]",
							},
						},
						"encoding",
						"fileformat",
						{ "filetype", icon_only = true },
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})

			local function get_buffers()
				local bufs = vim.fn.getbufinfo({ buflisted = 1 })
				local list = {}
				for _, b in ipairs(bufs) do
					table.insert(list, b.bufnr)
				end
				return list
			end

			for i = 1, 9 do
				vim.keymap.set("n", "<A-" .. i .. ">", function()
					local buflist = get_buffers()
					local bufnr = buflist[i]
					if bufnr then
						vim.cmd("buffer " .. bufnr)
					else
						vim.notify("No buffer at index " .. i, vim.log.levels.WARN)
					end
				end, { silent = true })
			end
		end,
	},
}
