-- paint.lua
local UI = require("ui")

-- Vérifier si un écran est connecté
local monitor = peripheral.find("monitor")

if monitor then
    -- Constantes
    local WIDTH, HEIGHT = monitor.getSize()
    local MENU_WIDTH = 6
    local COLORS = {
        colors.white, colors.orange, colors.magenta, colors.lightBlue,
        colors.yellow, colors.lime, colors.pink, colors.gray,
        colors.lightGray, colors.cyan, colors.purple, colors.blue,
        colors.brown, colors.green, colors.red, colors.black
    }

    -- Variables
    local canvas = {}
    local currentColor = colors.white
    local ui = UI:new()

    -- Fonctions
    local function drawCanvas()
        monitor.setBackgroundColor(colors.black)
        monitor.clear()
        for y = 1, HEIGHT do
            for x = MENU_WIDTH + 1, WIDTH do
                monitor.setBackgroundColor(canvas[y] and canvas[y][x] or colors.black)
                monitor.setCursorPos(x, y)
                monitor.write(" ")
            end
        end
    end

    local function drawMenu()
        for i, color in ipairs(COLORS) do
            ui:addButton({
                x = 1,
                y = i,
                text = "  ",
                color = color,
                onClick = function()
                    currentColor = color
                    drawCanvas()
                end
            })
        end
        ui:addButton({
            x = 1,
            y = #COLORS + 1,
            text = "Save",
            onClick = saveImage
        })
        ui:addButton({
            x = 1,
            y = #COLORS + 2,
            text = "Open",
            onClick = openImage
        })
    end

    local function saveImage()
        if not fs.exists("paint") then
            fs.makeDir("paint")
        end
        print("Entrez le nom de l'image:")
        local imageName = io.read()
        local file = fs.open("paint/" .. imageName .. ".txt", "w")
        for y = 1, HEIGHT do
            for x = MENU_WIDTH + 1, WIDTH do
                file.write(canvas[y] and canvas[y][x] or colors.black)
                file.write(" ")
            end
            file.write("\n")
        end
        file.close()
        print("Image sauvegardée sous " .. imageName .. ".txt")
    end

    local function openImage()
        if not fs.exists("paint") then
            print("Aucune image sauvegardée trouvée.")
            return
        end
        local files = fs.list("paint")
        for i, file in ipairs(files) do
            print(i .. ". " .. file)
        end
        local choice = tonumber(io.read())
        if choice and files[choice] then
            local file = fs.open("paint/" .. files[choice], "r")
            canvas = {}
            local y = 1
            for line in file.readLine do
                local x = MENU_WIDTH + 1
                for color in string.gmatch(line, "%S+") do
                    canvas[y] = canvas[y] or {}
                    canvas[y][x] = tonumber(color)
                    x = x + 1
                end
                y = y + 1
            end
            file.close()
            drawCanvas()
        else
            print("Choix invalide.")
        end
    end

    local function handleClick(x, y)
        ui:click(x, y)
        if x > MENU_WIDTH then
            canvas[y] = canvas[y] or {}
            canvas[y][x] = currentColor
            monitor.setBackgroundColor(currentColor)
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
        ui:render(monitor)
    end

    -- Boucle principale
    drawMenu()
    drawCanvas()
    ui:render(monitor)

    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        if side == peripheral.getName(monitor) then
            handleClick(x, y)
        end
    end
else
    error("Aucun écran trouvé. Veuillez connecter un écran.")
end