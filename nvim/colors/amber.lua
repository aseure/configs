-- amber.lua — a dark Neovim colorscheme built around yellow and grey
-- Usage: :colorscheme amber

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "amber"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Palette
local c = {
  bg        = "#1a1a1a",
  bg_dark   = "#121212",
  bg_light  = "#242424",
  bg_sel    = "#333333",
  fg        = "#e8e0c8",
  fg_dim    = "#a89f8c",
  grey1     = "#3a3a3a",
  grey2     = "#555555",
  grey3     = "#777777",
  grey4     = "#999999",
  yellow    = "#f0c040",
  gold      = "#d4a017",
  amber     = "#ffbf00",
  orange    = "#e09050",
  red       = "#e05050",
  red_dark  = "#c03030",
  green     = "#8ab060",
  cyan      = "#70b8b0",
  blue      = "#6090c0",
  magenta   = "#b080b0",
  comment   = "#7898b8",  -- steel blue: cool tone, separates from warm palette
  none      = "NONE",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hi("Normal",         { fg = c.fg, bg = c.bg })
hi("NormalFloat",    { fg = c.fg, bg = c.bg_dark })
hi("FloatBorder",    { fg = c.grey3, bg = c.bg_dark })
hi("Cursor",         { fg = c.bg, bg = c.yellow })
hi("CursorLine",     { bg = c.bg_light })
hi("CursorLineNr",   { fg = c.yellow, bold = true })
hi("LineNr",         { fg = c.grey2 })
hi("SignColumn",     { bg = c.bg })
hi("ColorColumn",    { bg = c.bg_light })
hi("VertSplit",      { fg = c.grey1 })
hi("WinSeparator",   { fg = c.grey1 })
hi("StatusLine",     { fg = c.fg, bg = c.bg_light })
hi("StatusLineNC",   { fg = c.grey3, bg = c.bg_dark })
hi("TabLine",        { fg = c.grey3, bg = c.bg_dark })
hi("TabLineFill",    { bg = c.bg_dark })
hi("TabLineSel",     { fg = c.yellow, bg = c.bg, bold = true })
hi("WinBar",         { fg = c.fg_dim, bg = c.bg })
hi("WinBarNC",       { fg = c.grey3, bg = c.bg })
hi("Pmenu",          { fg = c.fg, bg = c.bg_dark })
hi("PmenuSel",       { fg = c.bg, bg = c.yellow })
hi("PmenuSbar",      { bg = c.grey1 })
hi("PmenuThumb",     { bg = c.grey3 })
hi("Visual",         { bg = c.bg_sel })
hi("VisualNOS",      { bg = c.bg_sel })
hi("Search",         { fg = c.bg, bg = c.amber })
hi("IncSearch",      { fg = c.bg, bg = c.yellow, bold = true })
hi("CurSearch",      { fg = c.bg, bg = c.yellow, bold = true })
hi("Substitute",     { fg = c.bg, bg = c.orange })
hi("MatchParen",     { fg = c.yellow, bg = c.grey1, bold = true })
hi("Folded",         { fg = c.grey4, bg = c.bg_light })
hi("FoldColumn",     { fg = c.grey2, bg = c.bg })
hi("NonText",        { fg = c.grey1 })
hi("SpecialKey",     { fg = c.grey2 })
hi("Whitespace",     { fg = c.grey1 })
hi("EndOfBuffer",    { fg = c.grey1 })
hi("Directory",      { fg = c.yellow })
hi("Title",          { fg = c.yellow, bold = true })
hi("Question",       { fg = c.yellow })
hi("MoreMsg",        { fg = c.green })
hi("ModeMsg",        { fg = c.fg_dim })
hi("MsgArea",        { fg = c.fg })
hi("WildMenu",       { fg = c.bg, bg = c.yellow })

-- Diff
hi("DiffAdd",        { bg = "#1e2e1e" })
hi("DiffChange",     { bg = "#2a2a1a" })
hi("DiffDelete",     { fg = c.red_dark, bg = "#2e1e1e" })
hi("DiffText",       { bg = "#3a3a1a", bold = true })

-- Diagnostics
hi("DiagnosticError",          { fg = c.red })
hi("DiagnosticWarn",           { fg = c.orange })
hi("DiagnosticInfo",           { fg = c.blue })
hi("DiagnosticHint",           { fg = c.cyan })
hi("DiagnosticOk",             { fg = c.green })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn",  { sp = c.orange, undercurl = true })
hi("DiagnosticUnderlineInfo",  { sp = c.blue, undercurl = true })
hi("DiagnosticUnderlineHint",  { sp = c.cyan, undercurl = true })
hi("DiagnosticVirtualTextError", { fg = c.red, bg = "#2a1a1a" })
hi("DiagnosticVirtualTextWarn",  { fg = c.orange, bg = "#2a2418" })
hi("DiagnosticVirtualTextInfo",  { fg = c.blue, bg = "#1a1e2a" })
hi("DiagnosticVirtualTextHint",  { fg = c.cyan, bg = "#1a2a28" })

-- Syntax (Vim legacy groups)
hi("Comment",        { fg = c.comment, italic = true })
hi("Constant",       { fg = c.orange })
hi("String",         { fg = c.green })
hi("Character",      { fg = c.green })
hi("Number",         { fg = c.orange })
hi("Boolean",        { fg = c.orange })
hi("Float",          { fg = c.orange })
hi("Identifier",     { fg = c.fg })
hi("Function",       { fg = c.yellow, bold = true })
hi("Statement",      { fg = c.yellow })
hi("Conditional",    { fg = c.yellow })
hi("Repeat",         { fg = c.yellow })
hi("Label",          { fg = c.yellow })
hi("Operator",       { fg = c.fg_dim })
hi("Keyword",        { fg = c.gold })
hi("Exception",      { fg = c.red })
hi("PreProc",        { fg = c.gold })
hi("Include",        { fg = c.gold })
hi("Define",         { fg = c.gold })
hi("Macro",          { fg = c.gold })
hi("PreCondit",      { fg = c.gold })
hi("Type",           { fg = c.amber })
hi("StorageClass",   { fg = c.gold })
hi("Structure",      { fg = c.amber })
hi("Typedef",        { fg = c.amber })
hi("Special",        { fg = c.orange })
hi("SpecialChar",    { fg = c.orange })
hi("Tag",            { fg = c.yellow })
hi("Delimiter",      { fg = c.grey4 })
hi("SpecialComment", { fg = c.comment, bold = true })
hi("Debug",          { fg = c.red })
hi("Underlined",     { underline = true })
hi("Error",          { fg = c.red, bold = true })
hi("Todo",           { fg = c.bg, bg = c.yellow, bold = true })
hi("Added",          { fg = c.green })
hi("Changed",        { fg = c.yellow })
hi("Removed",        { fg = c.red })

-- Treesitter
hi("@comment",               { link = "Comment" })
hi("@variable",              { fg = c.fg })
hi("@variable.builtin",      { fg = c.orange })
hi("@variable.parameter",    { fg = c.fg_dim })
hi("@variable.member",       { fg = c.fg })
hi("@constant",              { fg = c.orange })
hi("@constant.builtin",      { fg = c.orange, bold = true })
hi("@string",                { link = "String" })
hi("@string.escape",         { fg = c.orange })
hi("@string.regex",          { fg = c.orange })
hi("@number",                { link = "Number" })
hi("@boolean",               { link = "Boolean" })
hi("@function",              { fg = c.yellow, bold = true })
hi("@function.builtin",      { fg = c.yellow })
hi("@function.call",         { fg = c.yellow })
hi("@function.method",       { fg = c.yellow })
hi("@function.method.call",  { fg = c.yellow })
hi("@constructor",           { fg = c.amber })
hi("@keyword",               { fg = c.gold })
hi("@keyword.function",      { fg = c.gold })
hi("@keyword.return",        { fg = c.gold })
hi("@keyword.operator",      { fg = c.gold })
hi("@keyword.conditional",   { fg = c.yellow })
hi("@keyword.repeat",        { fg = c.yellow })
hi("@keyword.exception",     { fg = c.red })
hi("@keyword.import",        { fg = c.gold })
hi("@operator",              { fg = c.fg_dim })
hi("@punctuation.bracket",   { fg = c.grey4 })
hi("@punctuation.delimiter", { fg = c.grey4 })
hi("@punctuation.special",   { fg = c.orange })
hi("@type",                  { fg = c.amber })
hi("@type.builtin",          { fg = c.amber })
hi("@type.qualifier",        { fg = c.gold })
hi("@property",              { fg = c.fg })
hi("@attribute",             { fg = c.gold })
hi("@tag",                   { fg = c.yellow })
hi("@tag.attribute",         { fg = c.gold })
hi("@tag.delimiter",         { fg = c.grey4 })
hi("@markup.heading",        { fg = c.yellow, bold = true })
hi("@markup.bold",           { bold = true })
hi("@markup.italic",         { italic = true })
hi("@markup.link",           { fg = c.blue, underline = true })
hi("@markup.link.url",       { fg = c.blue, underline = true })
hi("@markup.raw",            { fg = c.green })
hi("@markup.list",           { fg = c.yellow })

-- LSP semantic tokens
hi("@lsp.type.function",     { fg = c.yellow, bold = true })
hi("@lsp.type.method",       { fg = c.yellow })
hi("@lsp.type.property",     { fg = c.fg })
hi("@lsp.type.variable",     { fg = c.fg })
hi("@lsp.type.parameter",    { fg = c.fg_dim })
hi("@lsp.type.type",         { fg = c.amber })
hi("@lsp.type.class",        { fg = c.amber })
hi("@lsp.type.interface",    { fg = c.amber })
hi("@lsp.type.enum",         { fg = c.amber })
hi("@lsp.type.enumMember",   { fg = c.orange })
hi("@lsp.type.namespace",    { fg = c.gold })
hi("@lsp.type.keyword",      { fg = c.gold })
hi("@lsp.type.decorator",    { fg = c.gold })
hi("@lsp.mod.deprecated",    { strikethrough = true })

-- Git signs (gitsigns.nvim)
hi("GitSignsAdd",    { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.red })

-- fzf-lua
hi("FzfLuaNormal",        { fg = c.fg, bg = c.bg_dark })
hi("FzfLuaBorder",        { fg = c.grey2, bg = c.bg_dark })
hi("FzfLuaTitle",         { fg = c.yellow, bg = c.bg_dark, bold = true })
hi("FzfLuaPreviewNormal", { fg = c.fg, bg = c.bg })
hi("FzfLuaPreviewBorder", { fg = c.grey2, bg = c.bg })
hi("FzfLuaPreviewTitle",  { fg = c.gold, bg = c.bg, bold = true })
hi("FzfLuaCursorLine",    { bg = c.bg_sel })
hi("FzfLuaCursorLineNr",  { fg = c.yellow, bg = c.bg_sel })
hi("FzfLuaSearch",        { fg = c.bg, bg = c.amber })
hi("FzfLuaScrollBorderEmpty", { fg = c.grey1, bg = c.bg_dark })
hi("FzfLuaScrollBorderFull",  { fg = c.yellow, bg = c.bg_dark })
hi("FzfLuaScrollFloatEmpty",  { fg = c.grey1, bg = c.bg_dark })
hi("FzfLuaScrollFloatFull",   { fg = c.yellow, bg = c.bg_dark })
hi("FzfLuaHeaderBind",    { fg = c.gold })
hi("FzfLuaHeaderText",    { fg = c.fg_dim })
hi("FzfLuaBufName",       { fg = c.yellow })
hi("FzfLuaBufNr",         { fg = c.gold })
hi("FzfLuaBufFlagCur",    { fg = c.amber })
hi("FzfLuaBufFlagAlt",    { fg = c.grey4 })
hi("FzfLuaTabTitle",      { fg = c.yellow, bold = true })
hi("FzfLuaTabMarker",     { fg = c.amber })
hi("FzfLuaLiveSym",       { fg = c.amber })
hi("FzfLuaPathColNr",     { fg = c.grey4 })
hi("FzfLuaPathLineNr",    { fg = c.gold })

-- Indent guides
hi("IndentBlanklineChar",        { fg = c.grey1 })
hi("IblIndent",                  { fg = c.grey1 })
hi("IblScope",                   { fg = c.grey2 })

-- Lazy / Mason
hi("LazyButton",       { fg = c.fg, bg = c.bg_light })
hi("LazyButtonActive",  { fg = c.bg, bg = c.yellow, bold = true })
hi("LazyH1",            { fg = c.bg, bg = c.yellow, bold = true })

-- Notify
hi("NotifyERRORBorder", { fg = c.red_dark })
hi("NotifyERRORTitle",  { fg = c.red })
hi("NotifyERRORIcon",   { fg = c.red })
hi("NotifyWARNBorder",  { fg = c.gold })
hi("NotifyWARNTitle",   { fg = c.orange })
hi("NotifyWARNIcon",    { fg = c.orange })
hi("NotifyINFOBorder",  { fg = c.grey2 })
hi("NotifyINFOTitle",   { fg = c.yellow })
hi("NotifyINFOIcon",    { fg = c.yellow })

-- mini.cursorword
hi("MiniCursorword",        { fg = c.amber, underline = true, bold = true })
hi("MiniCursorwordCurrent", { fg = c.amber, underline = true, bold = true })
