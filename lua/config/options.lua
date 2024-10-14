local gset = vim.g

gset.mapleader = " "
gset.maplocalleader = " "

gset.loaded_python3_provider = 0
gset.loaded_perl_provider = 0

local set = vim.opt

set.number = true
set.cursorline = true
set.relativenumber = true
set.undofile = true
set.mouse = "a"
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

vim.schedule(function()
	set.clipboard = "unnamedplus"
end)

vim.g.clipboard = {
	name = "WslClipboard",
	copy = {
		["+"] = "clip.exe",
		["*"] = "clip.exe",
	},
	paste = {
		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r", ""))',
		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r", ""))',
	},
	cache_enabled = 0,
}
