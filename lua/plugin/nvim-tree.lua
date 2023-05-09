-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local api = require("nvim-tree.api")

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  api.tree.open()
end

local function copy_file_to(node)
    local file_src = node['absolute_path']
    -- The args of input are {prompt}, {default}, {completion}
    -- Read in the new file path using the existing file's path as the baseline.
    local file_out = vim.fn.input("COPY TO: ", file_src, "file")
    -- Create any parent dirs as required
    local dir = vim.fn.fnamemodify(file_out, ":h")
    vim.fn.system { 'mkdir', '-p', dir }
    -- Copy the file
    vim.fn.system { 'cp', '-R', file_src, file_out }
end

vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})
local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  hijack_cursor = true,
  renderer = {
    full_name = true,
    group_empty = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = false,
        folder_arrow = false,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  view = {
    adaptive_size = false,
--    mappings = {
--        list = {
--            {key="c", action = "copy_file_to", action_cb=copy_file_to}
--        }
--    },
}})

local function opts(desc)
  return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

vim.keymap.set('n', '<2-Tab>', api.node.open.preview,                 opts('Open Preview'))
vim.keymap.set('n', 'V', api.node.open.vertical,                opts('Open: Vertical Split'))
vim.keymap.set('n', 'T', api.node.open.tab,                     opts('Open: New Tab'))

vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))

api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)


