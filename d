local carList = {}

-- تستقبل رسالة الشات من السيرفر
function script.onChatMessage(message)
    if message:find("Available cars:") then
        local jsonPart = message:match("Available cars: (.+)")
        if jsonPart then
            carList = ac.decodeJSON(jsonPart)
        end
    end
end

function script.drawUI()
    local x, y = 300, 200

    ui.beginWindow("CarListWindow", vec2(x, y), vec2(300, 400))
    ui.text("Cars on server:")
    for i, car in ipairs(carList) do
        ui.text(string.format("%d: %s (Skin: %s)", car.Id, car.Model, car.Skin))
    end
    ui.endWindow()
end
