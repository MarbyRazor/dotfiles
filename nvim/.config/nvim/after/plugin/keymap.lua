vim.keymap.set('i', 'jk', "<ESC>")

-- Moving lines

vim.keymap.set('n', '<A-j>', ":m .+1<CR>==")
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==")
vim.keymap.set('i', '<A-j>', "<Esc>:m .+1<CR>==")
vim.keymap.set('i', '<A-k>', "<Esc>:m .-2<CR>==")
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

