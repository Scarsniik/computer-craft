local UI = require("ui")

-- Vérifier si un écran est connecté
local monitor = peripheral.find("monitor")

if monitor then
    local ui = UI:new()

    ui:new(5, 5, "Click me", colors.blue)
    ui:render()
end