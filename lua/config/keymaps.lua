local map = vim.keymap.set
local dmap = vim.keymap.del

-- Close current buffer
map('n', '<a-d>', '<CMD>bdelete<CR>', { desc = 'Close current bdeletebuffer' })
-- Close current window
map('n', '<a-q>', '<CMD>q<CR>', { desc = 'Close current window' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<CMD>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<c-h>', '<c-w><c-h>', { desc = 'Move focus to the left window' })
map('n', '<c-l>', '<c-w><c-l>', { desc = 'Move focus to the right window' })
map('n', '<c-j>', '<c-w><c-j>', { desc = 'Move focus to the lower window' })
map('n', '<c-k>', '<c-w><c-k>', { desc = 'Move focus to the upper window' })

-- Naviagate buffers
map('n', '<a-a>', '<CMD>bnext<cr>', { noremap = true, silent = true, desc = 'Navigate next buffer' })
map('n', '<a-s>', '<CMD>bprevious<cr>', { noremap = true, silent = true, desc = 'Navigate previous buffer' })

-- Modify Split Size
map('n', '<c-up>', '<CMD>resize -2<CR><cr>', { noremap = true, silent = true, desc = 'Resize split Up' })
map('n', '<c-down>', '<CMD>resize +2<CR><cr>', { noremap = true, silent = true, desc = 'Resize split Down' })
map('n', '<c-left>', '<CMD>vertical resize -2<cr>', { noremap = true, silent = true, desc = 'Resize split Left' })
map('n', '<c-right>', '<CMD>vertical resize +2<cr>', { noremap = true, silent = true, desc = 'Resize split Right' })

-- [[ Diagnostic keymaps ]]
map('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'Open diagnostic [L]ocation list' })
map('n', '<leader>lq', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open Floating diagnostic ' })
map('n', '<leader>ln', vim.diagnostic.get_next, { desc = 'Open diagnostic Next Diagnostic' })
map('n', '<leader>lp', vim.diagnostic.get_prev, { desc = 'Open diagnostic Previous Diagnostic' })

-- local v = vim.version.parse(vim.system({ "nvim", "--version" }, { text = true }):wait().stdout)
-- if v == "0.10.*" then
-- 	return
-- else
-- 	-- Deleted default keymaps to avoid duplicates
-- 	dmap({ "n", "x" }, "gra")
-- 	dmap("n", "grr")
-- 	dmap("n", "grn")
-- 	dmap("i", "<c-s>")
-- 	dmap("n", "gri")
-- end
