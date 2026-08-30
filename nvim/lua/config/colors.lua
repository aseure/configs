local red_color = "#f56565"

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, fg = red_color, sp = red_color })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, fg = red_color, sp = red_color })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, fg = red_color, sp = red_color })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, fg = red_color, sp = red_color })

vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#51202A" })
vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = "#51412A" })
vim.api.nvim_set_hl(0, "DiagnosticLineInfo", { bg = "#1E535D" })
vim.api.nvim_set_hl(0, "DiagnosticLineHint", { bg = "#1E205D" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = red_color })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = red_color })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = red_color })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = red_color })

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#dee5ed" })
