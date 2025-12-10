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

			vim.keymap.set({ "i", "s" }, "<C-k>,", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-j>,", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			-- Expand snippet using Alt+q
			vim.keymap.set({ "n", "v" }, "<C-q>", function()
				local snippets = ls.get_snippets("all")
				for _, snip in ipairs(snippets or {}) do
					if snip.trigger == "cl" then
						ls.snip_expand(snip)
						return
					end
				end
				print("No snippet found for 'cl'")
			end, { desc = "Insert console.log snippet" })

			-- Expand console.dir version using Alt+a
			vim.keymap.set({ "n", "v" }, "<C-a>", function()
				local snippets = ls.get_snippets("all")
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
			local t = ls.text_node

			-- Javascript, typescript, jsx
			ls.add_snippets("all", {
				s("cl", {
					t("console.log('\\n"),
					i(1),
					t(" :---->',"),
					i(2),
					t(")"),
				}),
				s("cld", {
					t("console.log('\\n"),
					i(1),
					t(" :---->');"),
					t("console.dir("),
					i(2),
					t(", { depth: null });"),
				}),
			})
		end,
	},
}
