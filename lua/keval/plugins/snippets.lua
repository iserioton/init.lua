return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},

		config = function()
			local ls = require("luasnip")
			-- require("luasnip.loaders.from_lua").lazy_load()
			-- When we want to load snippets from files eg. ~/.config/nvim/LuaSnip/javascript.lua

			ls.filetype_extend("javascript", { "jsdoc" })

			vim.keymap.set({ "i", "s" }, "<A-k>,", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<A-j>,", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<A-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			-- Expand snippet using Alt+q
			vim.keymap.set({ "n", "v" }, "<A-q>", function()
				local ft = vim.bo.filetype
				local snippets = ls.get_snippets(ft)
				for _, snip in ipairs(snippets or {}) do
					if snip.trigger == "cl" then
						ls.snip_expand(snip)
						return
					end
				end
				print("No snippet found for 'cl'")
			end, { desc = "Insert console.log snippet" })

			-- Expand console.dir version using Alt+a
			vim.keymap.set({ "n", "v" }, "<A-a>", function()
				local ft = vim.bo.filetype
				local snippets = ls.get_snippets(ft)
				for _, snip in ipairs(snippets or {}) do
					if snip.trigger == "cld" then
						ls.snip_expand(snip)
						return
					end
				end
				print("No snippet found for 'cld'")
			end, { desc = "Insert console.dir snippet" })

			------ Snippets -------
			local s = ls.snippet
			local i = ls.insert_node
			local f = ls.function_node
			local t = ls.text_node

			-- Lua snippets
			ls.add_snippets("lua", {
				s("hello", {
					t('print("Hello'),
					i(1),
					t(' world!")'),
				}),
			})

			-- Javascript
			ls.add_snippets("javascript", {
				s("cl", {
					f(function(_, parent)
						-- TODO: @iserioton fix the selection of text
						local text = parent.snippet.env.SELECT_RAW
						if not text or #text == 0 then
							return "console.log('\\n', );"
						end
						if type(text) == "table" then
							text = table.concat(text, "\n")
						end
						return "console.log('\\n" .. text .. "', " .. text .. ");"
					end, {}, {}),
				}),

				s("cld", {
					f(function(_, parent)
						local text = parent.snippet.env.SELECT_RAW
						if not text or #text == 0 then
							return "console.log('\\n:----> ');\\nconsole.dir('', { depth: null });"
						end
						if type(text) == "table" then
							text = table.concat(text, "\n")
						end
						return "console.log('\\n"
							.. text
							.. ":----> ');\\nconsole.dir("
							.. text
							.. ", { depth: null });"
					end, {}, {}),
				}),
			})
		end,
	},
}
