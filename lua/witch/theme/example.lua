local M = {}

--- @function syntax(colors, theme_style) : table
--- @author SonTung
--- @description
--- This function is invoked when the theme is loaded if no filetypes, buftypes, or events
--- are specified in the configuration of this module.
--- This function must returns the dictionary of highlight groups or an array of highlight groups.
---
--- The dictionary must have the following structure:
--- key: highlight group name
--- value: highlight options
---
--- e.g.
--- return {
--- 	Normal = { fg = colors.fg, bg = colors.bg },
---   NormalFloat = { fg = colors.fg, bg = colors.bg },
---   NormalNC = { fg = colors.fg, bg = colors.bg },
---   -- ...
--- }
---
--- The array must have the following structure:
--- {
---   highlight group name (string),
---    highlight options (table)
--- }
---
--- e.g.
--- return {
---   {
---     "Normal",
---     { fg = colors.fg, bg = colors.bg }
---   },
---   {
---     "NormalFloat",
---     { fg = colors.fg, bg = colors.bg }
---   },
---   -- ...
--- }
---
--- So why the array? Because the order of the highlight groups is important.
--- Some times you need to set the highlight group before another one.
--- So the array is the best way to do that.
--- Witch the array the highlight groups with smaller index will be set before
--- the highlight groups with bigger index.
--- It's same like the ranks in the a game, yah top 1 is the best.
---
---@param colors table : The readonly color table from witch
---@param theme_style any : The theme style from witch
---@return table : The highlight dict or array
---@usage M.syntax = function(colors, theme_style) return {} end
M.syntax = function(colors, theme_style) return {} end

-- If you provide M.colors here,
-- the colors argument in M.syntax will be the M.colors
-- else the colors argument in M.syntax will be the witch.colors from witch
M.colors = {}

-- If you provide M.on_highlight here,
-- the on_highlight argument in M.syntax will be the M.on_highlight
-- else the on_highlight argument in M.syntax will be the config.theme.on_highlight from opts in witch.setup(opts)
M.on_highlight = function(stype, colors, highlight) end

M.filetypes = {
	-- if you provide a filetype here with no value
	-- so the M.syntax function will be called when this filetype is loaded
	"NvimTree",

	-- if you provide a filetype here like a key and a value is a function
	-- so the function like other M.syntax and will be called when this filetype is loaded
	markdown = function(colors, theme_style) end,
}

M.buftypes = {
	-- same as M.filetypes but for buftypes

	"terminal",

	terminal = function(colors, theme_style) end,
}

M.events = {
	-- same as M.filetypes but for events
	-- but with one difference that when the value is a table with following structure:
	-- InsertEnter = {
	-- 	syntax = function(colors, theme_style) end,
	-- 	pattern = {},
	-- },
	-- the syntax property is same as M.syntax
	-- the pattern will be used to match the pattern of the event
	--

	"InsertEnter",

	InsertEnter = function(colors, theme_style) end,

	User = {
		syntax = function(colors, theme_style) end,
		pattern = { "VeryLazy" },
	},
}

-- So how to call it when an key is pressed?
-- I thought about it and I think the best way is to use the vim.keymap.set with
-- the api that i provided you in witch.theme.api
-- So you can call the function like this:
-- See more about the vim.keymap.set in the :h vim.keymap.set
vim.keymap.set("n", "f", function()
	-- M is the module that you provided
	require("witch.theme.api").highlight(M)

	-- you can do more things here
end)

return M
