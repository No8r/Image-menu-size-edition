local TFM, GET, playerList = tfm.exec, tfm.get, tfm.get.room.playerList
local players = {}
local imgs = {}

local emojis = {
    {key = 90 , img = "16f56cbc4d7.png"},
    {key = 88 , img = "16f56cdf28f.png"},
    --{key = 67 , img = "16f56ce925e.png"},
    {key = 86 , img = "16f56d09dc2.png"},
    {key = 66 , img = "16f5d8c7401.png"},
    {key = 77 , img = "17088661168.png"},
    {key = 78 , img = "16f56ce925e.png"},
}

local module = {
    admins = {({pcall(nil)})[2]:match".-#%d+"},
    commands = {"max", "msg", "fly"},
    keys = {"90","88","67","86","66","77","78","0","2","17","32","3","4"},
    maxSize = 3,
    fly = false,
}

local langue = {
    ar = {
        welcomeText = "<fc>!مرحبا بك في الفانكورب</fc>\n <j>هنا يمكنك تغيير حجمك و شكل فأرك بالشكل الذي يحلو لك</j>",
        youAre      = "<fc>!<b>%s</b> لقد تحولت إلى<fc>",
        changesize  = "تغيير الحجم",
        images      = "صور",
        setMaxSize  = "<fc><b>%s</b> تم تعيين الحد الأقصى للحجم [•]</fc>",
        canfly      = "<fc>يمكنكم الطيران عن طريق زر المسطرة [•]</fc>",
        cantfly      = "<fc>لا يمكنك الطيران بعد الآن [•]</fc>",
        note        = "<rose>[ملاحظة للمسؤولين] عندما يتم تحديد العدد الأقصى للحجم بعدد أكبر من 5 فيمكن تغيير حجم الصور أكتر من 5 أما الفئران تبقى على حالها</rose>"

    },
    en = {
        welcomeText = "<fc>Welcome to funcorp!</fc>\n <j>Here you can change your mouse's image and change your size as you want.</j>",
        youAre      = "<fc>You transformed into <b>%s</b>!<fc>",
        changesize  = "Change Size",
        images      = "Images",
        setMaxSize  = "<fc>[•] The maximum size is set to <b>%s</b></fc>",
        canfly      = "<fc>[•] You can fly now by press Spacebar!</fc>",
        cantfly     = "<fc>[•] You can't fly anymore.</fc>",
        note        = "<rose>[Admins Note] When you set the max size more than 5 you can change the image size but orginal mouse won't.</rose>"
    },
}

local images = {
    {"Crewmate",
        {
            {"Red", "178bcd41232.png", 110.5, 190},
            {"Yellow", "178bcd44113.png", 110.5, 190},
            {"White", "178bcd429a3.png", 110.5, 190},
            {"Orange", "178bcd3fac1.png", 110.5, 190},
            {"Lime", "178bcd3e350.png", 110.5, 190},
            {"Green" , "178bcd3cbdf.png", 110.5, 190},
            {"Lime", "178bcd3e350.png", 110.5, 190},
            {"Gray" , "178bcd3b46b.png", 110.5, 190},
            {"Blue" , "178bcd38589.png", 110.5, 190},
        }
    },
    {"Robot Mouse (By Spinnando#0000)",
        {
            {"White", "178bdf96b2a.png", 128, 190},
            {"Normal" , "178bdf9829a.png", 128, 190},
            {"Colorful" , "178bdf9b17e.png", 128, 190},
            {"Red" , "178bdf9c8ee.png", 128, 190},
            {"Golden", "178bdf99a0b.png", 128, 190},
            {"Cyan", "178bdf9e05e.png", 128, 190},
            {"Green", "178bdf9f7d0.png", 128, 190},
            {"Purple", "178bdfa0f42.png", 128, 190},
        }
    },
    {"Cute Ghost",
        {
            {"Beige", "178c09a08a0.png", 132, 190},
            {"Yellow", "178c099f12f.png", 132, 190},
            {"White", "178c099936d.png", 132, 190},
            {"Purple", "178c09a2012.png", 132, 190},
            {"Green" , "178c099d9bd.png", 132, 190},
            {"Pink", "178c099c24c.png", 132, 190},
            {"Light Blue" , "178c099aada.png", 132, 190},
        }
    },
    {"Sheep",
        {
            {"White", "178cc1108e3.png", 175.5, 190},
            {"Black", "178cc112054.png", 175.5, 190},
            {"Purple", "178cc1137c6.png", 175.5, 190},
            {"Blue", "178cc114f37.png", 175.5, 190},
            {"Pink", "178cc1166ab.png", 175.5, 190},
            {"Orange", "178cc117e1c.png", 175.5, 190},
            {"Yellow", "178cc11958e.png", 175.5, 190},
            {"Green", "178cc11ad00.png", 175.5, 190},
        }
    },
    {"Skeleton", "1789e6b9058.png", 122.5, 170},
    {"Meli Mouse", "178cbf1ff84.png", 140, 180},
    {"Rabbit", "178a763048a.png", 105, 220},
    {"Deer", "1792c9cacd8.png", 136.5, 190},
    {"Kangaroo", "178a8fd60a4.png", 132.5, 190},
    {"Dora Mouse", "178ab77286f.png", 140, 190},
    {"Creepy Cupid", "178a8eedcd1.png", 161.5, 175},
    {"Skelaton Cat", "1792c9cd64e.png", 195, 180},
    {"Chicken", "1789e74c570.png", 135, 170},
    {"Scarecrow", "1789e83df76.png", 135, 170},
    {"Fish", "17897d80b92.png", 50, 150},
    {"Crazy SpongePop", "178a7684993.png", 143, 170},
    {"Patrick", "178a8cc2fa2.png", 113.5, 190},
    {"Tentacles", "178c0ae903f.png", 192, 190},
    {"Tentacles2", "178c1ea37d2.png", 140, 190},
    {"Spiderman", "1789d2c38cf.png", 74, 170},
    {"Dancing Dora", "17a2b117411.png", 100, 180},
    {"Dora", "1789d45e0a4.png", 117, 170},
    {"Jerry", "17898047f7a.png", 92.5, 160},
    {"Triangle Jerry", "1789e5aece6.png", 150, 155},
    {"Standing Jerry", "1789e6216c4.png", 98, 170},
    {"Hungry Nibbbles", "1792c9c8635.png", 129.5, 180},
    {"Cardi b", "178a8c50903.png", 171.5, 180},
    {"Confused Girl", "17a24638fe5.png", 122.5, 180},
    {"Disgusted Boy", "17a2462dea9.png", 143, 180},
    {"Yelling Girl", "17a2969f993.png", 110, 180},
    {"Meli", "178c1db92ce.png", 127.5, 180},
    {"Surprised Pikachu", "178c1dbc1b1.png", 174, 180},
    {"Surprised Cat", "178c1dbaa41.png", 175, 180},
    {"Seated Fox", "178f74e11bb.png", 101, 180},
    {"Pro Cat", "1792c9c4b6b.png", 114.5, 180},
    {"Cute cat", "17a296a8bb0.png", 132.5, 180},
    {"Hamster1", "179d3702e39.png", 100, 180},
    {"Hamster2", "179d3705de7.png", 140, 180},
    {"Hamster3", "179d3a777a5.png", 145, 180},
    {"Hamster4", "17a2b118b83.png", 170, 180},
    {"Laughing guy", "179d3a6ea1e.png", 127.5, 180},
    {"Rainbow Unicorn", "17a296e5244.png", 137, 180},
    {"Sonickles", "17a297a663d.png", 172.5, 180},
    {"Spongepop fish", "17a2b11452f.png", 164.5, 180},
    {"Garcello", "179d36c4ab3.png", 92.5, 180},
    {"Doge", "17a2b115ca3.png", 109, 180},
    {"Drake", "17a2b11a2f6.png", 189.5, 180},
    {"Hiii", "17a2b11ba68.png", 130, 180},
    {"Angelena", "17a2b11d1d9.png", 145, 180},
}

function isAdmin(name)
    local theyAre
    for _,admin in next, module.admins do
        if admin == name then
            theyAre = true
        end
    end
    if theyAre then return true else return false end
end

function translate(id, name)
    local p = players
    if p[name] then
        if langue[p[name].langue] then
            if langue[p[name].langue][id] then
                return langue[p[name].langue][id]
            else
                return langue["en"][id]
            end
        elseif langue["en"] then
            return langue["en"][id]
        else
            return "error"
        end
    end
end

function openMenu(name ,page)
    local y = 20
    if not page then page = 1 end
    if not imgs[name].imgMenu then imgs[name].imgMenu = {} end
    if imgs[name].imgMenu[1] then TFM.removeImage(imgs[name].imgMenu[1]) end
    addButton(100, "", 20, 65 + y, 40, 40, "previousPage", name)
    addButton(101, "", 745, 65 + y, 40, 40, "nextPage", name)
    addButton(102, "", 720, 10 + y, 30, 30, "closeMenu", name)
    imgs[name].imgMenu[1] = TFM.addImage("178982ce017.png", ":1", 0, y, name)
    if imgs[name].imgMenuCustomize then 
        for i = 1, #imgs[name].imgMenuCustomize do 
            TFM.removeImage(imgs[name].imgMenuCustomize[i])
        end
    end
    for i = 2, 7 do
        if imgs[name].imgMenu[i] then TFM.removeImage(imgs[name].imgMenu[i]) end
        local id = (page-1)*6 + (i - 1)
        removeButton(i - 1, name)
        if images[id] then
            local x, imageScale, img, xImage, yImage = 90 + 110 * (i - 2) , 0.25, images[id][2], images[id][3], images[id][4]
            addButton(i - 1, "<font color = '#ffd991' size = '10'>"..images[id][1], x, 108 + y, 80, 20, images[id][1], name)
            if type(images[id][2]) == "table" then img, xImage, yImage = images[id][2][1][2], images[id][2][1][3], images[id][2][1][4] imgs[name].imgMenuCustomize[#imgs[name].imgMenuCustomize+1] = TFM.addImage("178bda8cef5.png", "&444", x-10, y+40, name, 0.75, 0.75) end
            imgs[name].imgMenu[i] = TFM.addImage(img, ":" .. i, (x+40) - (xImage/4), y + 80 - (yImage/4), name, imageScale, imageScale)
        end
    end
end

function closeMenu(name)
    table.removeImages(imgs[name].imgMenuCustomize)
    for i = 1,7 do 
        removeButton(i, name)
        removeButton(99+i, name)
        if imgs[name].imgMenu[i] then 
            TFM.removeImage(imgs[name].imgMenu[i])
        end
    end
end

function table.removeImages(table)
    if type(table) == "table" then
        for i = 1, #table do
            TFM.removeImage(table[i])
        end
    end
end

function addButton(id, text, x, y, xSize, ySize, callback, name)
    ui.addTextArea(10000 + id,"<p align = 'center'>" .. text, name, x, y, xSize, ySize, 0x011, 0x011, 0, true)
    ui.addTextArea(20000 + id, "<p align = 'center'><a href='event:" .. callback .. "'><font size = '20'>\n\n\n\n", name, x, y, xSize, ySize, 0x0111, 0x0111, 0, true)
end

function removeButton(id, name)
    ui.removeTextArea(10000 + id, name)
    ui.removeTextArea(20000 + id, name)
end

function eventNewPlayer(name)
    imgs[name] = {imgMenuCustomize = {}, imgMenu = {}}
    for _,key in next,module.keys do 
        TFM.bindKeyboard(name, key, true)
    end
    if not players[name] then 
        players[name] = {size = 1, img = nil, character = nil, facingLeft = false, language = playerList[name].language, imgMenu = {page = 1, selectedImg = nil}}
    end
    updateSizeAll(module.maxSize)
    TFM.chatMessage(translate("welcomeText", name) , name)
    TFM.addImage("1789e8ac789.png", ":9", 5, 353, name)
    TFM.addImage("1788d26ed0d.png", ":10", 0, 373, name)
    TFM.addImage("1788d26ed0d.png", ":11", 125, 373, name)
    addButton(90, "<font color = '#ffd991'><b>"..translate("images", name), 10, 380, 110, 40, "openMenu", name)
    addButton(91, "<font color = '#ffd991'><b>"..translate("changesize", name), 135, 380, 110, 40, "changesize", name)
    addButton(92, "<font color = '#ffd991'><b>\n", 5, 347, 40, 30, "normalMouse", name)
    updateImageForAll()
end

function eventChatCommand(name, c)
    local cmd, u = {}, 1
    for i in string.gmatch(c, "%S+") do
        cmd[u] = i
        u = u + 1
    end
    if isAdmin(name) then
        if cmd[1] == "max" then
            local size = tonumber(cmd[2])
            print(size)
            if type(size) == "number" then 
                module.maxSize = tonumber(cmd[2])
                for n in next, playerList do 
                    TFM.chatMessage(string.format(translate("setMaxSize", n), module.maxSize), n)
                end
                updateSizeAll(size)
                updateImageForAll()
            end
        elseif cmd[1] == "fly" then 
            if module.fly then 
                module.fly = false
                translatedMessageForAll("cantfly")
            else
                module.fly = true
                translatedMessageForAll("canfly")
            end
        elseif cmd[1] == "msg" then
            TFM.chatMessage("<fc> • ["..name.."]</fc><n> "..c:sub(4))
        end
    end
end

function translatedMessageForAll(msg)
    for n in next,playerList do 
        TFM.chatMessage(translate(msg, n),n)
    end
end

function updateSizeAll(size)
    for n in next, playerList do 
        if players[n] then 
            if players[n].size > size then 
                players[n].size = size
                TFM.changePlayerSize(n , players[n].size)
            end
        end
    end
end

function updateImage(name)
    if players[name] then
        if players[name].character then
            if players[name].img then TFM.removeImage(players[name].img) end
            local img = players[name].character 
            local xScale, yScale = players[name].size * 0.2 , players[name].size * 0.2  
            local mouseImg, x, y = img[2], (img[3]/5) * players[name].size , (img[4]/5) * players[name].size  
            if players[name].facingLeft then 
                xScale  = xScale * -1
                x = x * -1
            end
            players[name].img = TFM.addImage(mouseImg, "%" .. name , -x, -y, nil, xScale, yScale)
        end
    end
end

function updateImageForAll()
    for n in next,players do
        updateImage(n)
    end
end

print(math.ceil(#images/6))
function eventTextAreaCallback(id, name, cb)
    if cb == "closeMenu" then 
        closeMenu(name)
    elseif cb == "openMenu" then
        openMenu(name, players[name].imgMenu.page)
    elseif cb == "changesize" then
        ui.addPopup(1, 2, "<p align='center'><font color='#ffd991'>"..translate("changesize", name).."</font>\n (0.1 -> "..module.maxSize.." )", name, 325, 200, 150, true)
    elseif cb == "nextPage" then
        if players[name].imgMenu.page == math.ceil(#images/6) then players[name].imgMenu.page = 1 else players[name].imgMenu.page = players[name].imgMenu.page + 1 end
        openMenu(name, players[name].imgMenu.page)
    elseif cb == "previousPage" then 
        if players[name].imgMenu.page == 1 then players[name].imgMenu.page = math.ceil(#images/6) else players[name].imgMenu.page = players[name].imgMenu.page - 1 end
        openMenu(name, players[name].imgMenu.page)
    elseif cb == "normalMouse" then
        if players[name].img then 
            players[name].character = nil
            TFM.removeImage(players[name].img)
            TFM.killPlayer(name)
        end
    end
    for i = 1, #images do 
        if cb == images[i][1] then
            local player = players[name]
            local imgName = images[i][1]
            if type(images[i][2]) ~= "table" then 
                player.character = images[i]
            else
                player.character = images[i][2][math.random(#images[i][2])]
                imgName =  player.character[1] .. " " .. imgName
            end
            updateImage(name)
            TFM.chatMessage(string.format(translate("youAre", name), imgName), name)
        end
    end
end


function eventPopupAnswer(id , name, answer)
    if id == 1 then
        if answer then
            local size = tonumber(answer)
            if type(size) == "number" then
                if module.maxSize < size then size = module.maxSize elseif size < 0.1 then size = 0.1 end
                players[name].size = size
                TFM.changePlayerSize(name , players[name].size)
                updateImage(name)    
            end
        end
    end
end

function eventKeyboard(name, k)
    if k == 0 then
        players[name].facingLeft = true
        updateImage(name)
    elseif k == 2 then
        players[name].facingLeft = false
        updateImage(name)
    elseif k == 32 then
        if module.fly then 
            TFM.movePlayer(name, 0, 0, true, 0, -33)
        end
    end
    for _,emoji in pairs(emojis) do
        if k == emoji.key then
            if players[name].emoji then 
                TFM.removeImage(players[name].emoji)
            end
            players[name].emoji = tfm.exec.addImage(emoji.img,"$" .. name, -15,-61)
            players[name].emojiTime = 9
        end
    end    
end

function eventNewGame()
    updateImageForAll()
end

function eventLoop()
    for name in next, playerList do
        if players[name].emoji then
            if players[name].emojiTime > 0 then
                players[name].emojiTime = players[name].emojiTime - 1 
            elseif players[name].emojiTime == 0 then
                TFM.removeImage(players[name].emoji)
                players[name].emoji = nil
            end
        end
    end
end

function main()
    for n in next,GET.room.playerList do 
        eventNewPlayer(n)
        TFM.killPlayer(n)
    end
    for _,c in pairs(module.commands) do
		system.disableChatCommandDisplay(c)
    end
end

main()
