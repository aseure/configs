local palette = {
	black = "#000000",
	bg = "#0c0d10",
	["bg+1"] = "#13151a",
	["bg+2"] = "#1a1d23",
	["bg+3"] = "#252830",
	["bg+4"] = "#353943",
	grey = "#6b7080",
	ash = "#a5a9b5",
	fg = "#e6e6e6",
	white = "#ffffff",
	pink = "#ff6ac1",
	blush = "#ffb8d9",
	green = "#a6e37f",
	gold = "#f0c674",
	sky = "#7cc7e8",
	red = "#ff5c5c",
	["green-bg"] = "#0f3318",
	["sky-bg"] = "#12283a",
	["sky-bg+1"] = "#1d4560",
	["red-bg"] = "#3d1014",
	["pink-bg"] = "#2e1426",
}

local editor = {
	ColorColumn = { bg = palette["bg+2"] },
	Conceal = { fg = palette.grey },
	CurSearch = { fg = palette.black, bg = palette.pink, bold = true },
	Cursor = { fg = palette.black, bg = palette.white },
	CursorColumn = { bg = palette["bg+2"] },
	CursorLine = { bg = palette["pink-bg"] },
	CursorLineNr = { fg = palette.pink, bold = true },
	Directory = { fg = palette.sky, bold = true },
	EndOfBuffer = { fg = palette["bg+4"] },
	ErrorMsg = { fg = palette.red, bold = true },
	FloatBorder = { fg = palette["bg+4"], bg = palette["bg+1"] },
	FloatTitle = { fg = palette.white, bg = palette["bg+1"], bold = true },
	FoldColumn = { fg = palette.grey },
	Folded = { fg = palette.ash, bg = palette["bg+2"] },
	lCursor = { link = "Cursor" },
	LineNr = { fg = palette.grey },
	MatchParen = { fg = palette.white, bg = palette["bg+4"], bold = true },
	ModeMsg = { fg = palette.white, bold = true },
	MoreMsg = { fg = palette.green, bold = true },
	NonText = { fg = palette["bg+4"] },
	Normal = { fg = palette.fg, bg = palette.bg },
	NormalFloat = { fg = palette.fg, bg = palette["bg+1"] },
	OkMsg = { fg = palette.green, bold = true },
	Pmenu = { fg = palette.fg, bg = palette["bg+2"] },
	PmenuExtra = { fg = palette.ash, bg = palette["bg+2"] },
	PmenuKind = { fg = palette.ash, bg = palette["bg+2"] },
	PmenuMatch = { fg = palette.gold, bg = palette["bg+2"], bold = true },
	PmenuMatchSel = { fg = palette.gold, bg = palette["bg+4"], bold = true },
	PmenuSbar = { bg = palette["bg+3"] },
	PmenuSel = { fg = palette.white, bg = palette["bg+4"], bold = true },
	PmenuThumb = { bg = palette.grey },
	Question = { fg = palette.green, bold = true },
	QuickFixLine = { bg = palette["bg+3"], bold = true },
	Search = { fg = palette.black, bg = palette.gold },
	SignColumn = { fg = palette.grey },
	SpecialKey = { fg = palette.grey },
	SpellBad = { sp = palette.red, undercurl = true },
	SpellCap = { sp = palette.gold, undercurl = true },
	SpellLocal = { sp = palette.sky, undercurl = true },
	SpellRare = { sp = palette.sky, undercurl = true },
	StatusLine = { fg = palette.fg, bg = palette["bg+3"] },
	StatusLineNC = { fg = palette.grey, bg = palette["bg+1"] },
	Substitute = { link = "CurSearch" },
	TabLine = { fg = palette.ash, bg = palette["bg+2"] },
	TabLineFill = { bg = palette["bg+1"] },
	TabLineSel = { fg = palette.white, bg = palette.bg, bold = true },
	Title = { fg = palette.white, bold = true },
	Visual = { fg = palette.bg, bg = palette.pink },
	WarningMsg = { fg = palette.gold, bold = true },
	Whitespace = { fg = palette["bg+4"] },
	WinBar = { fg = palette.fg, bold = true },
	WinBarNC = { fg = palette.grey },
	WinSeparator = { fg = palette["bg+4"] },
}

local syntax = {
	Comment = { fg = palette.sky },
	Constant = { fg = palette.gold },
	Delimiter = { fg = palette.ash },
	Error = { fg = palette.red, bold = true },
	Function = { fg = palette.blush },
	Identifier = { fg = palette.fg },
	Operator = { fg = palette.pink },
	PreProc = { fg = palette.pink },
	Special = { fg = palette.pink },
	SpecialComment = { link = "Comment" },
	Statement = { fg = palette.pink, bold = true },
	String = { fg = palette.green },
	Tag = { fg = palette.blush },
	Todo = { fg = palette.gold, bold = true },
	Type = { fg = palette.blush },
	Underlined = { fg = palette.sky, underline = true },
}

local diagnostics = {
	DiagnosticDeprecated = { strikethrough = true },
	DiagnosticError = { fg = palette.red },
	DiagnosticHint = { fg = palette.sky },
	DiagnosticInfo = { fg = palette.sky },
	DiagnosticOk = { fg = palette.green },
	DiagnosticUnderlineError = { sp = palette.red, undercurl = true },
	DiagnosticUnderlineHint = { sp = palette.sky, undercurl = true },
	DiagnosticUnderlineInfo = { sp = palette.sky, undercurl = true },
	DiagnosticUnderlineOk = { sp = palette.green, undercurl = true },
	DiagnosticUnderlineWarn = { sp = palette.gold, undercurl = true },
	DiagnosticUnnecessary = { fg = palette.grey },
	DiagnosticWarn = { fg = palette.gold },
	LspCodeLens = { fg = palette.grey },
	LspInlayHint = { fg = palette.grey, bg = palette["bg+1"] },
	LspReferenceRead = { bg = palette["bg+3"] },
	LspReferenceText = { bg = palette["bg+3"] },
	LspReferenceWrite = { bg = palette["bg+3"], underline = true },
	LspSignatureActiveParameter = { fg = palette.gold, bold = true, underline = true },
}

local diff = {
	Added = { fg = palette.green },
	Changed = { fg = palette.sky },
	DiffAdd = { bg = palette["green-bg"] },
	DiffChange = { bg = palette["sky-bg"] },
	DiffDelete = { fg = palette.red, bg = palette["red-bg"] },
	DiffText = { bg = palette["sky-bg+1"], bold = true },
	Removed = { fg = palette.red },
}

local treesitter = {
	["@attribute"] = { link = "PreProc" },
	["@comment.documentation"] = { link = "@comment" },
	["@comment.error"] = { link = "@comment" },
	["@comment.note"] = { link = "@comment" },
	["@comment.todo"] = { link = "@comment" },
	["@comment.warning"] = { link = "@comment" },
	["@constant.builtin"] = { link = "Constant" },
	["@constructor"] = { link = "Type" },
	["@function.builtin"] = { link = "Function" },
	["@markup.heading"] = { fg = palette.pink, bold = true },
	["@markup.link"] = { fg = palette.sky },
	["@markup.link.url"] = { link = "Underlined" },
	["@markup.list"] = { fg = palette.pink },
	["@markup.quote"] = { link = "Comment" },
	["@markup.raw"] = { link = "String" },
	["@module"] = { link = "Type" },
	["@module.builtin"] = { link = "Type" },
	["@string.escape"] = { link = "Special" },
	["@string.regexp"] = { link = "String" },
	["@string.special"] = { link = "String" },
	["@string.special.symbol"] = { link = "Constant" },
	["@string.special.path"] = { link = "Underlined" },
	["@tag.attribute"] = { link = "Identifier" },
	["@tag.builtin"] = { link = "Tag" },
	["@tag.delimiter"] = { link = "Delimiter" },
	["@type.builtin"] = { link = "Type" },
	["@variable"] = { link = "Identifier" },
}

local plugins = {
	BlinkCmpLabelMatch = { link = "PmenuMatch" },
	MiniIndentscopeSymbol = { fg = palette["bg+4"] },
	MiniJump2dDim = { fg = palette["bg+4"] },
	MiniJump2dSpot = { fg = palette.pink, bold = true, nocombine = true },
	MiniJump2dSpotAhead = { fg = palette.pink, nocombine = true },
	MiniJump2dSpotUnique = { fg = palette.pink, bold = true, nocombine = true },
	MiniStatuslineDevinfo = { fg = palette.fg, bg = palette["bg+4"] },
	MiniStatuslineFileinfo = { fg = palette.fg, bg = palette["bg+4"] },
	MiniStatuslineFilename = { fg = palette.fg, bg = palette["bg+3"] },
	MiniStatuslineModeCommand = { fg = palette.black, bg = palette.blush, bold = true },
	MiniStatuslineModeInsert = { fg = palette.black, bg = palette.green, bold = true },
	MiniStatuslineModeNormal = { fg = palette.black, bg = palette.fg, bold = true },
	MiniStatuslineModeOther = { fg = palette.black, bg = palette.sky, bold = true },
	MiniStatuslineModeReplace = { fg = palette.black, bg = palette.red, bold = true },
	MiniStatuslineModeVisual = { fg = palette.black, bg = palette.pink, bold = true },
	MiniTrailspace = { bg = palette["red-bg"] },
}

local terminal_colors = {
	palette["bg+3"],
	palette.red,
	palette.green,
	palette.gold,
	palette.sky,
	palette.pink,
	palette.sky,
	palette.fg,
	palette.grey,
	palette.red,
	palette.green,
	palette.gold,
	palette.sky,
	palette.pink,
	palette.sky,
	palette.white,
}

local function reset()
	if vim.g.colors_name then
		vim.cmd.highlight("clear")
	end
	vim.g.colors_name = "peony"
end

local function apply_highlights()
	for _, groups in ipairs({ editor, syntax, diagnostics, diff, treesitter, plugins }) do
		for group, definition in pairs(groups) do
			vim.api.nvim_set_hl(0, group, definition)
		end
	end
end

local function apply_terminal_colors()
	for index, color in ipairs(terminal_colors) do
		vim.g["terminal_color_" .. (index - 1)] = color
	end
end

local function apply_cursor_highlight()
	if not vim.o.guicursor:find("a:Cursor/lCursor", 1, true) then
		vim.opt.guicursor:append("a:Cursor/lCursor")
	end
end

reset()
apply_highlights()
apply_terminal_colors()
apply_cursor_highlight()
