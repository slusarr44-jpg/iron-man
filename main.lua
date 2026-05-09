-- Попытка загрузки библиотеки с проверкой
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

if not success then
    warn("Библиотека интерфейса не загрузилась! Проверь интернет или ссылку.")
    return
end

-- Возвращаем белую тему, но с защитой от ошибки
local Window = Library.CreateLib("PLUTONIUMJUS - CLASSIC", "Light")

-- Самые важные функции для проверки:
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Торнадо и Полет")

Section:NewButton("FE Super Ring", "Запуск", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/code/refs/heads/main/FE-SUPE-RING.lua"))()
end)

Section:NewButton("Fly (Полет)", "Летать", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

-- Остальной код из 32 теста...
