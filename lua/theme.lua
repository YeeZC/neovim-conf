vim.g.rainbow_active=1
vim.g.rehash256=1
-- vim.g.molokai_original=1
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true
local colorscheme = "sonokai"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end
-- vim.cmd([[
--     " Colorscheme
--     syntax enable
--     colorscheme sonokai
-- ]])
