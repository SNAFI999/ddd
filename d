local carList = {}

function script.onChatMessage(message)
    if message:find("Available cars:") then
        local jsonPart = message:match("Available cars: (.+)")
        if jsonPart then
            carList = ac.decodeJSON(jsonPart)
        end
    end
end

function script.drawUI()
    local windowX = 300
    local windowY = 200

    ui.beginWindow("CarListButtonWindow", vec2(windowX, windowY), vec2(200, 50))
    if ui.button("Show Cars", vec2(0, 0), vec2(200, 50)) then
        ac.sendChatMessage("!cars")
    end
    ui.endWindow()

    if #carList > 0 then
        ui.beginWindow("AvailableCarsWindow", vec2(windowX, windowY + 100), vec2(300, 400))
        ui.text("Cars on server:")
        for i, car in ipairs(carList) do
            ui.text(string.format("%d: %s (Skin: %s)", car.Id, car.Model, car.Skin))
        end
        ui.endWindow()
    end
end
