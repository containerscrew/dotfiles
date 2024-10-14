local map = vim.keymap.set
vim.g.mapleader = " " -- Set leader key to Space

-- Save current file
-- Press: Space + w
map("n", "<leader>w", ":w<cr>", { desc = "Save file", remap = true })

-- Move line down (visual mode)
-- Press: J (in visual mode)
map("v", "J", ":m '>+1<CR>gv=gv")

-- Move line up (visual mode)
-- Press: K (in visual mode)
map("v", "K", ":m '<-2<CR>gv=gv")

-- Exit insert mode by pressing jk
-- Press: jk (in insert mode)
map("i", "jk", "<ESC>", { desc = "jk to esc", noremap = true })

-- Quit Neovim
-- Press: Space + q
map("n", "<leader>q", ":q<cr>", { desc = "Quit Neovim", remap = true })

-- Increment numbers
-- Press: +
map("n", "+", "<C-a>", { desc = "Increment numbers", noremap = true })

-- Decrement numbers
-- Press: -
map("n", "-", "<C-x>", { desc = "Decrement numbers", noremap = true })

-- Select all
-- Press: Ctrl + a
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all", noremap = true })

-- Indent left (visual mode)
-- Press: <
map("v", "<", "<gv", { desc = "Indenting", silent = true, noremap = true })

-- Indent right (visual mode)
-- Press: >
map("v", ">", ">gv", { desc = "Indenting", silent = true, noremap = true })

-- Open a new tab
-- Press: t + e
map("n", "te", ":tabedit")

-- Split window horizontally
-- Press: Space + sh
map("n", "<leader>sh", ":split<Return><C-w>w", { desc = "splits horizontal", noremap = true })

-- Split window vertically
-- Press: Space + sv
map("n", "<leader>sv", ":vsplit<Return><C-w>w", { desc = "Split vertical", noremap = true })

-- Navigate to the pane above
-- Press: Ctrl + k
map("n", "<C-k>", "<C-w>k", { desc = "Navigate up" })

-- Navigate to the pane below
-- Press: Ctrl + j
map("n", "<C-j>", "<C-w>j", { desc = "Navigate down" })

-- Navigate to the pane on the left
-- Press: Ctrl + h
map("n", "<C-h>", "<C-w>h", { desc = "Navigate left" })

-- Navigate to the pane on the right
-- Press: Ctrl + l
map("n", "<C-l>", "<C-w>l", { desc = "Navigate right" })

-- Change 2 split windows from vertical to horizontal
-- Press: Space + th
map("n", "<leader>th", "<C-w>t<C-w>H", { desc = "Change window splits to horizontal", noremap = true })

-- Change 2 split windows from horizontal to vertical
-- Press: Space + tk
map("n", "<leader>tk", "<C-w>t<C-w>K", { desc = "Change window splits to vertical", noremap = true })

-- Resize window (shrink vertically)
-- Press: Ctrl + Up Arrow
map("n", "<C-Up>", ":resize -3<CR>")

-- Resize window (expand vertically)
-- Press: Ctrl + Down Arrow
map("n", "<C-Down>", ":resize +3<CR>")

-- Resize window (shrink horizontally)
-- Press: Ctrl + Left Arrow
map("n", "<C-Left>", ":vertical resize -3<CR>")

-- Resize window (expand horizontally)
-- Press: Ctrl + Right Arrow
map("n", "<C-Right>", ":vertical resize +3<CR>")

-- Go to next buffer
-- Press: Tab
map("n", "<Tab>", ":bnext<cr>", { desc = "Move to next tab", noremap = true })

-- Go to previous buffer
-- Press: Shift + Tab
map("n", "<S-Tab>", ":bprevious<cr>", { desc = "Move to previous tab", noremap = true })

-- Close current buffer
-- Press: Space + x
map("n", "<leader>x", ":bd<cr>", { desc = "Buffer close", noremap = true })

-- Toggle comments (normal/visual mode)
-- Press: Space + co
map({"n", "v"}, "<leader>co", ":CommentToggle<cr>", { desc = "CommentToggle", noremap = true })

-- Telescope find files
-- Press: Space + ff
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find_files", noremap = true })

-- Telescope live grep
-- Press: Space + fg
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live_grep", noremap = true })

-- Telescope recent files
-- Press: Space + fr
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Telescope oldfiles", noremap = true })

-- Telescope list buffers
-- Press: Space + fb
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers", noremap = true })

-- Spectre toggle
-- Press: Space + S
map('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre", noremap = true })

-- Spectre search current word (normal mode)
-- Press: Space + sw
map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Spectre Search current word", noremap = true })

-- Spectre search current word (visual mode)
-- Press: Space + sw
map('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word", noremap = true })

-- Spectre search in current file
-- Press: Space + sp
map('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file", noremap = true })
