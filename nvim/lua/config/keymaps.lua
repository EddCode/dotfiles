-- ------Standard Bindings------
-- A way for switching relative numbers with a single map.
vim.keymap.set("n", "<F5>", ":set invrelativenumber<CR>", { silent = true })
vim.keymap.set("i", "<F5>", "<ESC>:set invrelativenumber<CR>a", { silent = true })
vim.keymap.set("n", "<leader>l", ":set list!<CR>", { silent = true })
vim.keymap.set("n", "<leader><Tab><Tab>", ":set noexpandtab<CR>", { silent = true, noremap = true })

-- Basic file system commands
vim.keymap.set("n", "<A-o>", ":!touch<Space>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-e>", ":!crf<Space>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-d>", ":!mkdir<Space>", { silent = true, noremap = true })
vim.keymap.set("n", "<A-m>", ":!mv<Space>%<Space>", { silent = true, noremap = true })

-- Shorcuts for switching buffers
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>p", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", ":buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>U", ":UndotreeShow<CR>", { silent = true, noremap = true })
-- quick semi
vim.keymap.set("n", "<leader>;", "$a;<Esc>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>w", ":w <CR>", { silent = true })

-- ==> resize horizontal windows
vim.keymap.set("n", "<leader>w+", "<C-w>5+", { silent = true })
vim.keymap.set("n", "<leader>w-", "<C-w>5-", { silent = true })
-- ==> resize vertical windows
vim.keymap.set("n", "<leader>w<", "<C-w>5<", { silent = true })
vim.keymap.set("n", "<leader>w>", "<C-w>5>", { silent = true })
-- ==> resize equal windows
vim.keymap.set("n", "<leader>w=", "<C-w>=", { silent = true })
-- ==> split windows
vim.keymap.set("n", "<leader>ws", ":sp <CR>", { silent = true })
vim.keymap.set("n", "<leader>wv", ":vsp <CR>", { silent = true })

vim.keymap.set("n", "<C-i>", ":new<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-s>", ":vnew<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-n>", ":wincmd w<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-c>", ":close<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>tv", ":botright vnew <Bar> :terminal <cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>th", ":botright new <Bar> :terminal <cr>", { silent = true, noremap = true })

-- =======================
-- " Run NodeJs & Golang
-- " =======================
-- run current file
vim.keymap.set("n", "<leader>xn", ":!node %<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xg", ":!go run %<cr>", { silent = true, noremap = true })

-- ==============================
-- Manage easeir windows actions
-- ==============================

-- Move through the windows
vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

-- Configuración de colores para GitSigns (asumiendo que lo usas)
vim.api.nvim_set_hl(0, "GitSignsAdded", { fg = "#50a14f", ctermfg = 2, bold = true })
vim.api.nvim_set_hl(0, "GitSignsRemoved", { fg = "#e74c3c", ctermfg = 1, bold = true })
vim.api.nvim_set_hl(0, "GitSignsChanged", { fg = "#f1c40f", ctermfg = 3, bold = true })
vim.api.nvim_set_hl(0, "GitSignsChangeRemoved", { fg = "#e64ce6", ctermfg = 5, bold = true })
