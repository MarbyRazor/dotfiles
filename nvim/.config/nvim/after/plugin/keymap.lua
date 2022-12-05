local nnoremap = require("marby.keymap").nnoremap
local inoremap = require("marby.keymap").inoremap

--nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- General INSERT MODE
inoremap("jk", "<ESC>")
-- nnoremap <leader>q :enew<bar>bd #<CR>
nnoremap("<leader>q", ":bw<CR>")

-- Telescope
nnoremap("<leader>ff", function()
	require("telescope.builtin").find_files()
end)

nnoremap("<leader>fg", function()
	require("telescope.builtin").live_grep()
end)

nnoremap("<leader>fb", function()
	require("telescope.builtin").buffers()
end)

nnoremap("<leader>fh", function()
	require("telescope.builtin").help_tags()
end)
