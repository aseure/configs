local red_color = "#f56565"

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, fg = red_color, sp = red_color })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, fg = red_color, sp = red_color })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, fg = red_color, sp = red_color })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, fg = red_color, sp = red_color })

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#dee5ed" })
