-- ui.lua

local UI = {}

function UI:new()
  local obj = {
    buttons = {}
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function UI:addButton(x, y, text, color, onClick)
  text = text or ""
  color = color or colors.white
  onClick = onClick or function() end
  local id = #self.buttons + 1
  self.buttons[id] = {
    x = x,
    y = y,
    text = text,
    color = color,
    onClick = onClick,
    width = #text
  }
  return id
end

function UI:updateButton(id, properties)
  if self.buttons[id] then
    for key, value in pairs(properties) do
      self.buttons[id][key] = value
    end
    if properties.text then
      self.buttons[id].width = #properties.text
    end
  end
end

function UI:removeButton(id)
  self.buttons[id] = nil
end

function UI:render(monitor)
  for _, button in pairs(self.buttons) do
    monitor.setBackgroundColor(button.color)
    monitor.setCursorPos(button.x, button.y)
    monitor.write(button.text)
  end
end

function UI:click(x, y)
  for _, button in pairs(self.buttons) do
    if x >= button.x and x < button.x + button.width and y == button.y then
      button.onClick()
      break
    end
  end
end

return UI