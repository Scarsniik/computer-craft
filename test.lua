-- test_ui.lua

local UI = require("ui")

-- Vérifier si un écran est connecté
local monitor = peripheral.find("monitor")

if monitor then
    local ui = UI:new()

    print("Test de création de boutons :")
    local button1 = ui:addButton({
        x = 5,
        y = 5,
        text = "Click me",
        color = colors.blue,
        textColor = colors.white,
        onClick = function()
            print("Button 1 clicked!")
        end
    })
    local button2 = ui:addButton({
        x = 5,
        y = 7,
        text = "Another button",
        color = colors.green,
        onClick = function()
            print("Button 2 clicked!")
        end
    })
    local button3 = ui:addButton({
        x = 5,
        y = 9,
        color = colors.red,
        onClick = function()
            print("Button 3 clicked!")
        end
    })

    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    ui:render(monitor)

    print("Test de mise à jour de boutons :")
    ui:updateButton(button1, { text = "Updated text", color = colors.orange })
    ui:updateButton(button2, { x = 10, y = 8 })
    ui:updateButton(button3, { text = "New text", color = colors.purple, textColor = colors.white })
    ui:render(monitor)

    print("Test de suppression de boutons :")
    ui:removeButton(button2)
    ui:render(monitor)

    print("Test de clics sur les boutons :")
    print("Cliquez sur les boutons de l'écran.")
    print("Appuyez sur 'q' pour quitter.")

    while true do
        local event, side, x, y = os.pullEvent()
        if event == "monitor_touch" and side == peripheral.getName(monitor) then
            print("Clic détecté aux coordonnées (x: " .. x .. ", y: " .. y .. ")")
            ui:click(x, y)
        elseif event == "key" and side == "q" then
            print("Touche 'q' enfoncée. Fin des tests.")
            break
        end
    end

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