vim.g.rainbow_active = 1
vim.g.rehash256 = 1
local colorscheme = "sonokai"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
    return
end
