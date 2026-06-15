-- Ghostty をマウスクリックでフォーカスした時、クリックを tmux に replay する
-- (macOS が消費した first click を synthetic click で補完)
local ghosttyFocusWatcher = hs.application.watcher.new(function(appName, event, app)
  if appName ~= "Ghostty" or event ~= hs.application.watcher.activated then return end

  local pos = hs.mouse.absolutePosition()

  hs.timer.doAfter(0.05, function()
    local front = hs.application.frontmostApplication()
    if not front or front:name() ~= "Ghostty" then return end

    local win = hs.window.frontmostWindow()
    if not win then return end
    local f = win:frame()
    if pos.x >= f.x and pos.x <= f.x + f.w
    and pos.y >= f.y and pos.y <= f.y + f.h then
      hs.eventtap.leftClick(pos)
    end
  end)
end)

ghosttyFocusWatcher:start()
