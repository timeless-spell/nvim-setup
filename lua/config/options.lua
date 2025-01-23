local gset = vim.g
local set = vim.opt

gset.mapleader = " "
gset.maplocalleader = " "

gset.loaded_python3_provider = 0
gset.loaded_perl_provider = 0

set.autoread = true
set.number = true
set.cursorline = true
set.relativenumber = true
set.undofile = true
set.mouse = "a"
set.mousemoveevent = true
set.ignorecase = true
set.smartcase = true
set.signcolumn = "yes"
set.updatetime = 250
set.splitright = true
set.splitbelow = true
set.inccommand = "split"
set.termguicolors = true
set.breakindent = true
set.backup = false
set.showmode = false
set.list = true
set.listchars = { tab = "| ", eol = "󰘌" }

gset.clipboard = {
	name = "win32yank-wsl",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -i --lf",
		["*"] = "win32yank.exe -i --lf",
	},
	cache_enabled = 0,
}
