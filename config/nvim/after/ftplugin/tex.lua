-- this refocuses NVIM after a VimTexView (forward search)
-- otherwise, it focuses on the PDF rendered, at least when i use i3.

if VIM_WINDOW_ID == nil then
  VIM_WINDOW_ID = vim.fn.system("xdotool getactivewindow")
end

local function tex_focus_vim()
  if VIM_WINDOW_ID == nil then
    return
  end

  vim.loop.sleep(200)
  vim.fn.system("xdotool windowfocus " .. VIM_WINDOW_ID)
end

local group = vim.api.nvim_create_augroup("vimtex_event_focus", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "VimtexEventView",
  group = group,
  callback = tex_focus_vim,
})
