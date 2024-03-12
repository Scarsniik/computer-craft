-- test_ui.lua

local UI = require("ui")

-- Vérifier si un écran est connecté
local monitor = peripheral.find("monitor")

if monitor then
    local ui = UI:new()

    print("Test de création de boutons :")
    local button1 = ui:addButton(5, 5, "Click me", colors.blue, function()
        print("Button 1 clicked!")
    end)
    local button2 = ui:addButton(5, 7, "Another button", colors.green, function()
        print("Button 2 clicked!")
    end)
    local button3 = ui:addButton(5, 9, "", colors.red, function()
        print("Button 3 clicked!")
    end)
    ui:render(monitor)

    print("Test de mise à jour de boutons :")
    ui:updateButton(button1, { text = "Updated text", color = colors.orange })
    ui:updateButton(button2, { x = 10, y = 8 })
    ui:updateButton(button3, { text = "New text", color = colors.purple })
    ui:render(monitor)

    print("Test de suppression de boutons :")
    ui:removeButton(button2)
    ui:render(monitor)

    print("Test de clics sur les boutons :")
    ui:click(5, 5) -- Devrait déclencher le bouton 1
    ui:click(10, 8) -- Devrait déclencher le bouton 2 (qui a été supprimé)
    ui:click(5, 9) -- Devrait déclencher le bouton 3
    ui:click(1, 1) -- Ne devrait déclencher aucun bouton

    print("Test de dessin graphique :")
    monitor.setBackgroundColor(colors.white)
    monitor.clear()
    ui:render(monitor)
    monitor.setCursorPos(1, 1)
    monitor.write("Test de dessin graphique")

    print("Fin des tests.")
else
    error("Aucun écran trouvé. Veuillez connecter un écran.")
end