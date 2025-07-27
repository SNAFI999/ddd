local carList = {}
local showWindow = false

-- دالة لتحليل JSON (لو مكتبة JSON موجودة في بيئة اللعبة)
local function parseJSON(jsonString)
    local json = require("json") -- تأكد من وجود مكتبة json أو استبدلها حسب البيئة
    local success, result = pcall(json.decode, jsonString)
    if success then
        return result
    end
    return nil
end

function script.onChatMessage(message)
    -- نتأكد أنها رسالة قائمة السيارات
    local prefix = "Available cars: "
    if message:sub(1, #prefix) == prefix then
        local jsonPart = message:sub(#prefix + 1)
        local cars = parseJSON(jsonPart)
        if cars then
            carList = cars
            showWindow = true
        end
    end
end

function script.drawUI()
    if showWindow then
        local screenSize = ui.screenSize()
        local windowPos = vec2(screenSize.x/2 - 150, screenSize.y/2 - 200)
        local windowSize = vec2(300, 400)

        ui.beginWindow("Car List", windowPos, windowSize, true, true)
        ui.text("Available Cars:")
        ui.separator()

        for i, car in ipairs(carList) do
            ui.text(string.format("%d: %s (Skin: %s)", car.Id, car.Model, car.Skin))
        end

        if ui.button("Close", vec2(120, 350), vec2(60, 30)) then
            showWindow = false
        end

        ui.endWindow()
    end
end
