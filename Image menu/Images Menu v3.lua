local TFM, GET, playerList = tfm.exec, tfm.get, tfm.get.room.playerList
local players = {}
local imgs = {}

TFM.disableAutoShaman(true)
TFM.disablePhysicalConsumables(true)
TFM.disableAfkDeath(true)

local emojis = {
    {key = 90 , img = "16f56cbc4d7.png"},
    {key = 88 , img = "16f56cdf28f.png"},
    --{key = 67 , img = "17aa1491af1.png"},
    {key = 86 , img = "16f56d09dc2.png"},
    {key = 66 , img = "16f5d8c7401.png"},
    {key = 77 , img = "17088661168.png"},
    {key = 78 , img = "16f56ce925e.png"},
}

local module = {
    admins = {({pcall(nil)})[2]:match".-#%d+"},
    commands = {"max", "msg", "fly","admin"},
    keys = {"90","88","67","86","66","77","78","0","2","17","32","3","4"},
    maxSize = 5,
    fly = true,
    speed = true,
}

local settings = {
    sizelimit = 5,
    fly = 0,
    speed = 0,
    nick = 0,
    colornick = 0,
}

local langue = {
    ar = {
        welcomeText      = "<fc>!مرحبا بك في الفانكورب</fc>\n <j>هنا يمكنك تغيير حجمك و شكل فأرك بالشكل الذي يحلو لك</j>\n (انقر فوق الصور أو تغيير الحجم) اضغط على مفتاح المسافة للطيران واضغط على\n Z X V B M N لمزيد من الوجوه</j>",
        youAre           = "<fc>!<b>%s</b> لقد تحولت إلى<fc>",
        changesize       = "تغيير الحجم",
        changenickname   = "الاسم",
        changenickcolor  = "لون الاسم",
        images           = "صور",

        canfly           = "<fc>يمكنكم الطيران عن طريق زر المسطرة [•]</fc>",
        cantuse          = "<fc>لا يمكنك استخدام %s الآن [•]</fc>",
        note             = "<rose>[ملاحظة للمسؤولين] عندما يتم تحديد العدد الأقصى للحجم بعدد أكبر من 5 فيمكن تغيير حجم الصور أكتر من 5 أما الفئران تبقى على حالها</rose>",
        langchange       = "<fc>!لقد تم تغيير اللغة [•]</fc>",

        changefly        = "<p align='center'><font color='#ffd991' size = '16'>تعيين قوة الطيران\n</font><font color='#D26F6F'>قم بكتابة 0 لإلغاء الطيران</font>\n (25 --> 70) الحجم الموصى به",
        changespeed      = "<p align='center'><font color='#ffd991' size = '16'>تعيين قوة السرعة\n</font><font color='#D26F6F'>قم بكتابة 0 لإلغاء السرعة المرافقة</font>",
        changesizelimit  = "<p align='center'><font color='#ffd991' size = '16'>تعيين حد الحجم</font>\n إذا قمت بتعيينه على أكثر من 5 فستكون الصور كذلك ، ولكن الحد الأقصى لحجم الفئران هو 5 لا يمكن أن يكون أكثر.",
        changenick       = "<p align='center'><font color='#ffd991' size = '16'>تعيين فترة الانتظار لتغيير الأسماء</font>\nاكتب 0 لتعطيل تغيير الاسم",
        changecolornick  = "<p align='center'><font color='#ffd991' size = '16'>تعيين فترة الانتظار لتغيير ألوان الأسماء</font>\nاكتب 0 لتعطيل تغيير لون الاسم",
        nickC            = "<p align='center'><font color='#ffd991' size = '16'>تغيير الاسم</font>\nإذا اخترت اسمًا غير مناسب أو حاولت انتحال هوية أحد ، فلن يتم تغيير اسمك",

        changedfly       = "<fc><b>%s</b> تم ضبط قوة الطيران على [•]</fc>",
        changedspeed     = "<fc><b>%s</b> تم ضبط السرعة الزائدة على [•]</fc>",
        changedsizelimit = "<fc><b>%s</b> تم تعيين الحد الأقصى للحجم [•]</fc>",
        changednick      = "<fc>!ثانية <b>%s</b> الآن يمكنك تغيير اسمك كل [•]</fc>",
        changedcolornick = "<fc>!ثانية <b>%s</b> الآن يمكنك تغيير لون اسمك كل [•]</fc>",

        speed            = "السرعة الزائدة",
        fly              = "الطيران",
        nick             = "تغيير الاسم",
        colornick        = "تغيير لون الاسم",

        off              = "معطل",
        usefly           = "<fc>الطيران عن طريق ضغط زر المسافة/المسطرة [•]</fc>",
        usespeed         = "<fc>السرعة : فقط امشِ و ستركض بشكل اسرع [•]</fc>",
        usenick          = "<fc> يمكنك تغيير اسمك كل %s ثانية [•]</fc>",
        usecolornick     = "<fc> يمكنك تغيير لون اسمك كل %s ثانية [•]</fc>",
        usesizelimit     = "<fc>لتغيير حجمك انقر رز تغيير الحجم <b>%s</b> الحد الأقصى للحجم [•]</fc>",

        waitAMoment      = "<fc> عليك الإنتظار %s ثانية لتتمكن من التغيير مرة أخرى [•]</fc>",
        chosencolor      = "<fc>بعد ثوانِِِ <font color='#%s'>#%s</font> سيتغير لون اسمك إلى [•]</fc>",
        chosenName       = "<fc>بعد ثوانِِِ <r>%s</r> سيتغير اسمك إلى</fc>",

        error_value      = "<r>لا يمكنك كتابة قيمة أقل من صفر [•]",

    },
    en = {
        welcomeText      = "<fc>Welcome to funcorp!</fc>\n <j>Here you can change your mouse's image and change your size as you want.</j>\n (Click Images or Change size) Press spacebar to fly and press Z X V B M N for more emotes.",
        youAre           = "<fc>You transformed into <b>%s</b>!<fc>",
        changesize       = "Change Size",
        changenickname   = "Nickname",
        changenickcolor  = "Nickname Color",
        images           = "Images",

        setMaxSize       = "<fc>[•] The maximum size is set to <b>%s</b></fc>",
        canfly           = "<fc>[•] You can fly now by press Spacebar!</fc>",
        cantuse          = "<fc>[•] You can't use %s now.</fc>",
        note             = "<rose>[Admins Note] When you set the max size more than 5 you can change the image size but orginal mouse won't.</rose>",
        langchange       = "<fc>[•] Language has changed!</fc>",

        changefly        = "<p align='center'><font color='#ffd991' size = '16'>Set Flying Power</font>\n<font color='#D26F6F'>Type 0 to disable the fly powers.</font>\n Recommended (25 --> 70)",
        changespeed      = "<p align='center'><font color='#ffd991' size = '16'>Set Speeding Power</font>\nType 0 to disable the speed powers.",
        changesizelimit  = "<p align='center'><font color='#ffd991' size = '16'>Set size limit</font>\n If you set it more than 5 then the images will be, but the max mouse size is 5 can't be more.",
        changenick       = "<p align='center'><font color='#ffd991' size = '16'>Set cooldown to change nicknames</font>\nType 0 to disable changing nicknames.",
        changecolornick  = "<p align='center'><font color='#ffd991' size = '16'>Set cooldown to nicknames color.</font>\nType 0 to disable changing nicknames color.",
        nickC            = "<p align='center'><font color='#ffd991' size = '16'>Change Nickname</font>\nIf you choose an inappropriate name or try to impersonation, your nickname will not be changed.",

        changedfly       = "<fc>[•] The fly power is set to <b>%s</b></fc>.",
        changedspeed     = "<fc>[•] The extra speed is set to <b>%s</b></fc>.",
        changedsizelimit = "<fc>[•] The maximum size is set to <b>%s</b></fc>",
        changednick      = "<fc>[•] Now you can change your nickname every <b>%s</b> seconds.</fc>.",
        changedcolornick = "<fc>[•] Now you can change your nickname color every <b>%s</b> seconds.</fc>",

        speed            = "extra speed powers",
        fly              = "fly powers",
        nick             = "changing nickname",
        colornick        = "changing nickname color",

        off              = "Off",
        usefly           = "<fc>[•] Fly by press SPACEBAR.</fc>",
        usespeed         = "<fc>[•] Speed : just walk and you'll run faster!</fc>",
        usenick          = "<fc>[•] You can change your nickname every %s seconds.</fc>",
        usecolornick     = "<fc>[•] You can change your nickname color every %s seconds.</fc>",
        usesizelimit     = "<fc><fc>[•] The maximum size is <b>%s</b>, you can change your size by click on Change Size button.</fc>",

        waitAMoment      = "<fc>[•] You must wait %s seconds to request again",
        chosencolor      = "<fc>[•] Your nickname color will change to <font color='#%s'>#%s</font>.</fc>",
        chosenName       = "<fc>[•] Your nickname will change to <r><b>%s</b></r> in moments.</fc>",

        error_value      = "<r>[ERROR] You can't type value less than zero."
    },
    br = {
        welcomeText      = "<fc>Seja bem-vindo ao FunCorp!</fc>\n <j>Aqui você pode alterar a imagem de seu ratinho e seu tamanho, caso queira.</j>\n (Clique em Imagens ou Alterar o tamanho) Pressione a barra de espaço para voar e pressione Z X C V B M N para mais ações",
        youAre           = "<fc>Você se transformou em <b>%s</b>!<fc>",
        changesize       = "Tamanho",
        changenickname   = "Apelido",
        changenickcolor  = "Cor do Apelido",
        images           = "Imagens",

        setMaxSize       = "<fc>[•] O tamanho máximo agora será <b>%s</b></fc>",
        canfly           = "<fc>[•] Agora você pode voar pressionando Espaço!</fc>",
        cantuse          = "<fc>[•] Você não pode usar %s agora.</fc>",
        note             = "<rose>[Nota aos Admins] Se você configurar o tamanho máximo maior que 5, você pode mudar o tamanho da imagem, mas não o rato original.</rose>",
        langchange       = "<fc>[•] Idioma alterado com sucesso!</fc>",

        changefly        = "<p align='center'><font color='#ffd991' size = '16'>Configurar poder de voo</font>\n<font color='#D26F6F'>Digite 0 para desativar os poderes de voar.</font>\n Recomandado (25 --> 70)",
        changespeed      = "<p align='center'><font color='#ffd991' size = '16'>Configurar poder de velocidade</font>\nDigite 0 para desativar os poderes de velocidade.",
        changesizelimit  = "<p align='center'><font color='#ffd991' size = '16'>Configurar tamanho limite</font>\n Se você definir mais de 5, as imagens irão parecer maiores, mas o tamanho máximo do mouse é 5 e não maior que isso.",
        changenick       = "<p align='center'><font color='#ffd991' size = '16'>Configurar o cooldown para alterar os apelidos</font>\nDigite 0 para desativar a alteração de apelidos.",
        changecolornick  = "<p align='center'><font color='#ffd991' size = '16'>Configurar o cooldown para alterar os cor dos apelidos.</font>\nDigite 0 para desativar a alteração de cores.",
        nickC            = "<p align='center'><font color='#ffd991' size = '16'>Mudar apelido</font>\nSe você escolher um nome impróprio ou tentar falsificar sua identidade, seu apelido não será alterado.",

        changedfly       = "<fc>[•] O poder de voo foi configurado para <b>%s</b></fc>.",
        changedspeed     = "<fc>[•] A velocidade extra foi configurado para <b>%s</b></fc>.",
        changedsizelimit = "<fc>[•] O tamanho máximo foi configurado para <b>%s</b></fc>",
        changednick      = "<fc>[•] Agora você pode mudar seu apelido a cada <b>%s</b> segundos.</fc>.",
        changedcolornick = "<fc>[•] Agora você pode mudar a cor do seu apelido a cada <b>%s</b> segundos.</fc>",

        speed            = "poderes de velocidade extra",
        fly              = "poderes de voo",
        nick             = "mudando o apelido",
        colornick        = "mudando a cor do apelido",

        off              = "Desativado",
        usefly           = "<fc>[•] Voe pressionando Espaço.</fc>",
        usespeed         = "<fc>[•] Velocidade: basta caminhar e você correrá mais rápido!</fc>",
        usenick          = "<fc>[•] Você pode mudar seu apelido a cada %s segundos.</fc>",
        usecolornick     = "<fc>[•] Você pode alterar a cor do seu apelido a cada %s segundos.</fc>",

        waitAMoment      = "<fc>[•] You must wait %s segundos para solicitar novamente",
        chosencolor      = "<fc>[•] A cor do seu apelido mudará para <font color='#%s'>#%s</font>.</fc>",
        chosenName       = "<fc>[•] Seu apelido mudará para <r><b>%s</b></r> já já.</fc>",

        error_value      = "<r>[ERRO] Você não pode digitar um valor menor que zero."
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
    {"Plush Mouse", "17a5e248b95.png", 92.5, 95},
    {"Chicken Mouse", "179515fe999.png", 85, 111.5},
    {"Anime Mouse", "17a5e35092b.png", 140, 265.5},
    {"Cheese Mouse", "17a5e3ed37f.png", 140, 235},
    {"Potato Mouse", "17a5e3f5a6a.png", 140, 245},
    {"Skeleton", "1789e6b9058.png", 122.5, 170},
    {"Meli Mouse", "178cbf1ff84.png", 140, 190},
    {"Rabbit", "178a763048a.png", 105, 230},
    {"Deer", "1792c9cacd8.png", 136.5, 190},
    {"Kangaroo", "178a8fd60a4.png", 132.5, 190},
    {"Dora Mouse", "178ab77286f.png", 140, 190},
    {"Creepy Cupid", "178a8eedcd1.png", 161.5, 190},
    {"Skeleton Cat", "1792c9cd64e.png", 195, 190},
    {"Smallchicken", "1789e74c570.png", 135, 190},
    {"Funny chicken", "17a6c742250.png", 135, 180},
    {"Rubber chicken", "17b40991910.png", 90, 180},
    {"Chicken", "17b4055f0ca.png", 266, 190},
    {"Dancing Dora", "17a2b117411.png", 100, 180},
    {"Dora", "1789d45e0a4.png", 117, 170},
    {"Boots", "17ba08b9c82.png", 100, 170},
    {"Thomas", "17a6d6f175c.png", 140, 190},
    {"Pepe Frog", "17a5ed4b6d8.png", 150, 190},
    {"Pepe Frog2", "17a5ed49d76.png", 150, 187},
    {"Pingu", "17a5f45f40f.png", 125, 100},
    {"Jerry", "17898047f7a.png", 92.5, 160},
    {"Triangle Jerry", "1789e5aece6.png", 150, 155},
    {"Standing Jerry", "1789e6216c4.png", 98, 170},
    {"Jerry look", "17b6e310957.png", 162.5, 180},
    {"Jerry looks sad", "17b6e3120ad.png", 112.5, 180},
    {"Jerry Sad", "17b6e30ab74.png", 109.5, 170},
    {"Dancing Jerry", "17b6e30f1c9.png", 74, 190},
    {"Jerry sitting", "17babb0841f.png", 140, 190},
    {"Tom Crying and Hugging", "17b6e30c2e7.png", 125, 180},
    {"Hungry Nibbbles", "1792c9c8635.png", 129.5, 180},
    {"Robbie Rotten", "17a6d6da5b8.png", 102.5, 260},
    {"Sportacus ", "17a6d6d8eae.png", 140, 260},
    {"Stephanie", "17a6d6dc08a.png", 110, 260},
    {"Cardi b", "178a8c50903.png", 171.5, 180},
    {"Confused Girl", "17a24638fe5.png", 122.5, 180},
    {"Disgusted Boy", "17a2462dea9.png", 143, 180},
    {"Trollface", "17a5f464191.png", 175, 180},
    {"Yelling Girl", "17a2969f993.png", 110, 180},
    {"Confused Cat", "17a5ed52619.png", 125, 113.5},
    {"Youdontsay", "17a5f465a2d.png", 180, 170},
    {"NOPE", "17a62b6347a.png", 105, 250},
    {"Meli", "178c1db92ce.png", 127.5, 180},
    {"Tigrounette", "17a5e4d9ed8.png", 127.5, 200},
    {"Surprised Pikachu", "178c1dbc1b1.png", 174, 180},
    {"Detective Pikachu", "17a5f45d7ec.png", 175, 220},
    {"Pikaman", "17a62b58ca8.png", 135, 210},
    {"Kirby", "17a5ed47eca.png", 112.5, 180},
    {"Mario", "17a64039c15.png", 130, 222},
    {"Mario Head", "17a640f28c4.png", 160, 180},
    {"Luigi", "17a64020805.png", 115, 275},
    {"Luigi Dab", "17a62b5548a.png", 125, 240},
    {"Yoshi", "17a62b6d22d.png", 120, 180},
    {"Donkey Kong", "17a6d6e01a8.png", 200, 190},
    {"Sitting Fox", "178f74e11bb.png", 101, 130},
    {"Laughing guy", "179d3a6ea1e.png", 127.5, 180},
    {"Harold", "17a62b71cc2.png", 170, 145},
    {"Hnnnngggg", "17a62b73ca1.png", 160, 170},
    {"Rainbow Unicorn", "17a296e5244.png", 137, 180},
    {"Da Wae", "17a5f460a67.png", 150, 160},
    {"Sonic", "17a5ed4d235.png", 159, 180},
    {"Sonickles", "17a297a663d.png", 172.5, 180},
    {"Tails", "17a6201e05d.png", 130, 210},
    {"Sans", "17a62b5b580.png", 100, 180},
    {"Papyrus", "17a62b5d4fe.png", 100, 190},
    {"Yee", "17a6401be1d.png", 125, 210},
    {"Garfield", "17a62b5f984.png", 175, 120},
    {"Marge", "17a6d6de0ec.png", 150, 170},
    {"Homer", "17ba2365308.png", 150, 180},
    {"Doge", "17a2b115ca3.png", 109, 180},
    {"Troll Doge", "17a6401f119.png", 109, 190},
    {"Corgi", "17a5f4625d7.png", 125, 125},
    {"Shaggy", "17a5ed3dd5f.png", 135, 205},
    {"Shrek", "17a5ed420ab.png", 100, 200},
    {"Shrek 2", "17a6c745137.png", 87.5, 180},
    {"Donkey", "17a64037647.png", 75, 230},
    {"Donkey 2", "17a6c740adf.png", 93, 180},
    {"Woody", "17a6401d645.png", 130, 250},
    {"HEYYEYAAEYAAAEYAEYAA", "17a5ed404ac.png", 140, 85},
    {"Clown", "17a6d6ecb9a.png", 145, 200},
    {"Gnomed", "17a6d6e47d4.png", 125, 250},
    {"Gordon Ramsay", "17a66d4cae1.png", 175, 170},
    {"Preminger", "17a6d6e2073.png", 125, 260},
    {"Jimmy Neutron", "17a6d6d68d6.png", 120, 260},
    {"Mouse holding cheese", "17a86f5af88.png", 129.5, 180},
    {"Flop Mouse", "17a61380339.png", 160, 50},
    {"Scarecrow", "1789e83df76.png", 135, 170},
    {"Hiii", "17a2b11ba68.png", 130, 180},
    {"Angelena", "17a2b11d1d9.png", 145, 180},
    {"Puppet Monkey", "17a6c7439c3.png", 156.5, 180},
    {"Puppet Monkey1", "17a6c7468a7.png", 161, 180},
    {"Puppet Monkey2", "17a6c749789.png", 107.5, 180},
    {"Kermit Frog", "17a6c74802b.png", 143.5, 180},
    {"Henlo", "17a86f551c3.png", 50, 180},
    {"Bongo Cat", "17a86f59814.png", 145, 110},
    {"Doja cat1", "17a867f8436.png", 95, 180},
    {"Doja cat2", "17a86818aae.png", 112, 180},
    {"Doja cat3", "17a867fb316.png", 114, 180},
    {"Doja cat4", "17a86872509.png", 167.5, 180},
    {"Ariana Grande", "17a86f580a4.png", 164, 180},
    {"Drake", "17a2b11a2f6.png", 189.5, 180},
    {"Billie Eilish", "17abba2a421.png", 95, 180},
    {"Kim Kardashian", "17abba25dcf.png", 103, 180},
    {"Jungkook", "17abba2753b.png", 106, 180},
    {"Jimin", "17abba2bb90.png", 111.5, 180},
    {"Taehyung", "17abba2d301.png", 123.5, 180},
    {"Salttt", "17b409a3882.png", 116.5, 180},
    {"Hamster1", "179d3702e39.png", 100, 180},
    {"Hamster2", "179d3705de7.png", 140, 180},
    {"Hamster3", "179d3a777a5.png", 145, 180},
    {"Hamster4", "17a2b118b83.png", 170, 180},
    {"Hamster5", "17a6c73dbfd.png", 150, 180},
    {"Hamster6", "17babb06cac.png", 162, 190},
    {"Boyfriend", "17ba08b074e.png", 125, 160},
    {"Girlfriend", "17a5f45b639.png", 115, 150},
    {"Pico", "17a6d6e6b32.png", 125, 150},
    {"Pico Maid", "17a6b733ffb.png", 100, 190},
    {"Whitty", "17a6c16e1bc.png", 100, 190},
    {"Cassette Girl", "17a6b8df819.png", 100, 190},
    {"held by Spiderman",
        {
            {"Nothing", "17b554c1dfc.png", 206, 190},
            {"Chicken", "17b554c356f.png", 206, 190},
            {"Meli", "17b554c4ce0.png", 206, 190},
            {"Cheese", "17b554c6454.png", 206, 190},

        }
    },
    {"Spiderman Staring", "17b554cc216.png", 215, 190},
    {"Spiderman Explaining", "17b554caaa6.png", 169.5, 190},
    {"Spiderman", "1789d2c38cf.png", 74, 170},
    {"Spiderman Love", "17b409a5d5e.png", 140, 190},
    {"Spiderman Confused", "17b7da79a77.png", 200, 190},
    {"Spongebob", "17a5ed4efff.png", 130, 221},
    {"Spongebob lady", "17b554c9336.png", 100, 190},
    {"Spongebob lady2", "17b7da76b94.png", 90, 190},
    {"Crazy Spongebob", "178a7684993.png", 143, 170},
    {"Patrick", "178a8cc2fa2.png", 113.5, 190},
    {"Patrick2", "17a5ed461a7.png", 110, 182},
    {"Squidward", "178c0ae903f.png", 192, 190},
    {"Squidward2", "178c1ea37d2.png", 140, 190},
    {"Squidward3", "17abba28cad.png", 205.5, 180},
    {"Squidward4", "17a6201be33.png", 150, 240},
    {"Squidward5", "17a6201a6ee.png", 140, 170},
    {"Mr. Krabs", "17a62b6188e.png", 175, 185},
    {"Fish1", "17897d80b92.png", 50, 150},
    {"Fish2", "17a6c73f36f.png", 100, 180},
    {"Fish3", "17a2b11452f.png", 164.5, 180},
    {"Cockroach (Spongebob)", "17b7da78305.png", 103, 190},
    {"Pro Cat", "1792c9c4b6b.png", 114.5, 185},
    {"Sad Cat", "17a5ed5409f.png", 150, 220},
    {"Cute Cat", "17a296a8bb0.png", 132.5, 185},
    {"Snail Cat", "17a5ed55c72.png", 140, 155},
    {"Pop Cat", "17a62b65d15.png", 135, 200},
    {"Surprised Cat", "178c1dbaa41.png", 175, 190},
    {"Crazy Cat", "17babb03dc9.png", 120, 190},
    {"Stylish Cat", "17babb0553b.png", 272.5, 190},
    {"Garcello", "179d36c4ab3.png", 92.5, 180},
    {"Penguin", "17b554c7bc4.png", 150, 190},
    {"Yeeh", "17b6e30da57.png", 140, 180},
}
print("<rose>Total Images : </rose>"..#images)

local langueIcon = {
    ar = "1651b32290a.png",
    br = "1651b3019c0.png",
    en = "1723dc10ec2.png",
    es = "1651b309222.png",
    fr = "1651b30c284.png",
    tr = "1651b3240e8.png",
    ro = "1651b31f950.png",
    hu = "1651b310a3b.png",
    ru = "1651b321113.png",
    de = "1651b306152.png",
}

function flagButton(name, pay, callback, x, y)
    local textareaId
    if callback == "closechangelangue" or callback == "openchangelangue" then textareaId = 0 else textareaId = #imgs[name].button + 1 end
    imgs[name].button[#imgs[name].button + 1] = TFM.addImage("1788d26ed0d.png", ":10", x, y, name, 0.23, 0.6)
    imgs[name].flag[#imgs[name].flag + 1] = TFM.addImage(langueIcon[pay], ":11", x + 7, y + 5, name)
    ui.addTextArea(70000 + textareaId , "<p align = 'center'><a href='event:" .. callback .. "'><font size = '20'>\n\n\n\n", name, x-3, y-2, 40, 20, 0x0111, 0x0111, 0, true)
end

function openChangelanguage(name)
    local id = 1
    for pay in next, langue do 
        if pay ~= players[name].language then  
            id = id + 1
            flagButton(name, pay , "changeto"..tostring(pay), (30 * id) + 18, 352)    
        end
    end
end

function closeChangeLangue(name)
    for i = 0, #imgs[name].button do
        if imgs[name].button[i] then TFM.removeImage(imgs[name].button[i]) imgs[name].button[i] = nil end
        if imgs[name].flag[i] then TFM.removeImage(imgs[name].flag[i]) imgs[name].flag[i] = nil end
        ui.removeTextArea(70000 + i, name)
    end
end

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
        if langue[p[name].language] then
            if langue[p[name].language][id] then
                return langue[p[name].language][id]
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

function adminsInterface(name)
    TFM.addImage("17b746c1b9e.png", ":8", 765, 370, name, 0.8, 0.8)
    addButton(300, "", 765, 370, 30, 30, "openSettingsMenu", name)
end

function adminMessage(msg)
    for _,admin in next, module.admins do 
        TFM.chatMessage(msg, admin)
    end
end

function openSettingsMenu(name, x, y)
    if imgs[name] then
        if imgs[name].SettingMenu then TFM.removeImage(imgs[name].SettingMenu) end
        imgs[name].SettingMenu = TFM.addImage("17ba730e389.png", ":5", x, y, name)
        addButton(200, "", x + 180, y+5, 30, 30, "closeSettingsMenu", name)
        for t, button in next, {{x + 50, y + 50, "sizelimit"}, {x + 125, y + 50, "fly"}, {x + 50, y + 140, "speed"}, {x + 125, y + 140, "colornick"}, {x + 50, y + 230, "nick"} } do
            local text = settings[button[3]] 
            if text == 0 then text = translate("off", name) end
            ui.addTextArea(9999 - t, "<p align = 'center'><font size = '14' color='#ffd991' face='soopafresh'><b>"..text, name, button[1], button[2] + 42 , 58, 28, 0x20140e , 0x20140e , 0, true)
            addButton(200 + t, "", button[1], button[2], 60, 60, "change"..button[3], name)
        end
    end
end

function closeSettingsMenu(name)
    if imgs[name].SettingMenu then TFM.removeImage(imgs[name].SettingMenu) end imgs[name].SettingMenu = nil
    removeButton(200, name)
    for i = 1, 5 do 
        ui.removeTextArea(9999 - i, name)
        removeButton(200 + i, name)
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
    imgs[name].imgMenu[1] = TFM.addImage("17ba22afcf6.png", ":1", 0, y, name)
    if imgs[name].imgMenuCustomize then 
        for i = 1, #imgs[name].imgMenuCustomize do 
            TFM.removeImage(imgs[name].imgMenuCustomize[i])
        end
    end
    for t = 1, 6 do 
        if imgs[name].imgMen[t] then TFM.removeImage(imgs[name].imgMen[t]) end
    end
    for t = 1,6 do 
        imgs[name].imgMen[t] = TFM.addImage("17ba22ada0c.png", ":1", 80 + 110 * (t-1), y + 40, name)
    end
    for i = 2, 7 do
        if imgs[name].imgMenu[i] then TFM.removeImage(imgs[name].imgMenu[i]) end
        local id = (page-1)*6 + (i - 1)
        removeButton(i - 1, name)
        if images[id] then
            local x, imageScale, img, xImage, yImage = 86 + 110 * (i-2) , 0.21, images[id][2], images[id][3], images[id][4]
            addButton(i - 1, "<font color = '#ffd991' size = '10'>"..images[id][1], x, 108 + y, 80, 20, images[id][1], name)
            if type(images[id][2]) == "table" then img, xImage, yImage = images[id][2][1][2], images[id][2][1][3], images[id][2][1][4] imgs[name].imgMenuCustomize[#imgs[name].imgMenuCustomize+1] = TFM.addImage("178bda8cef5.png", "&444", x-10, y+40, name, 0.75, 0.75) end
            imgs[name].imgMenu[i] = TFM.addImage(img, ":" .. i, (x - (xImage/4)) + 45, y + 90 - (yImage/4), name, imageScale, imageScale)
        end
    end
end

function closeMenu(name)
    table.removeImages(imgs[name].imgMenuCustomize)
    for i = 1,7 do 
        removeButton(i, name)
        removeButton(99+i, name)
        if imgs[name].imgMen[i-1] then 
            TFM.removeImage(imgs[name].imgMen[i-1])
        end
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

function eventPlayerDied(name)
    TFM.respawnPlayer(name)
end

function eventNewPlayer(name)
    imgs[name] = {imgMenuCustomize = {}, imgMenu = {},imgMen = {}, button = {}, flag = {}}
    TFM.respawnPlayer(name)
    for _,key in next,module.keys do 
        TFM.bindKeyboard(name, key, true, true)
        TFM.bindKeyboard(name, key, false, true)
    end
    if not players[name] then 
        players[name] = {size = 1, interface= {}, img = nil, character = nil, facingLeft = false, language = GET.room.playerList[name].community, imgMenu = {page = 1, selectedImg = nil}}
    end
    updateSizeAll(settings.sizelimit)
    TFM.chatMessage(translate("welcomeText", name) , name)
    TFM.addImage("1789e8ac789.png", ":9", 5, 353, name)
    playersInterface(name)
    updateImageForAll()
    adminsInterface(name)
end

function playersInterface(name)
    for k, t in next, {{10, 380, "images", "openMenu"}, {135, 380, "changesize", "changesize"}, {10, 20, "changenickname", "changingnick"}, {135, 20, "changenickcolor", "changingnickcolor"}} do 
        if not players[name].interface[k] then 
            players[name].interface[k] = TFM.addImage("1788d26ed0d.png", ":11", t[1] - 10 , t[2] - 7, name)
        end
        addButton(90 + k, "<font color = '#ffd991'><b>"..translate(t[3], name), t[1], t[2], 110, 40, t[4], name)
    end
    addButton(90, "<font color = '#ffd991'><b>\n", 5, 347, 40, 30, "normalMouse", name)
    flagButton(name, players[name].language , "openchangelangue", 45, 352)
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
            if type(size) == "number" then 
                settings.sizelimit = tonumber(cmd[2])
                for n in next, playerList do 
                    TFM.chatMessage(string.format(translate("setMaxSize", n), settings.sizelimit), n)
                end
                updateSizeAll(size)
                updateImageForAll()
            end
        elseif cmd[1] == "msg" then
            TFM.chatMessage("<fc> • ["..name.."]</fc><n> "..c:sub(4))
        elseif cmd[1] == "admin" then
            setAdmin(cmd[2])
        end
    end
end

function setAdmin(name)
    if not name then return end
    local admin = name:sub(1,1):upper()..name:sub(2):lower()
    if players[admin] then 
        if not isAdmin(admin) then 
            table.insert(module.admins , admin)
            adminMessage(string.format("<rose>[FUNCORP] %s is now an admin.<rose>", name))
        end
    end
end

function translatedMessageForAll(msg, ...)
    for n in next,playerList do 
        TFM.chatMessage(string.format(translate(msg, n), ...),n)
    end
end

function updateSizeAll(size)
    for n in next, playerList do 
        if players[n] then 
            if players[n].size > size then 
                players[n].size = size
                TFM.changePlayerSize(n , players[n].size)
                updateImage(name)
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

function eventTextAreaCallback(id, name, cb)
    if cb == "closeMenu" then 
        closeMenu(name)
    elseif cb == "openMenu" then
        openMenu(name, players[name].imgMenu.page)
    elseif cb == "changesize" then
        ui.addPopup(1, 2, "<p align='center'><font color='#ffd991'>"..translate("changesize", name).."</font>\n (0.1 -> "..settings.sizelimit.." )", name, 325, 200, 150, true)
    elseif cb == "nextPage" then
        if players[name].imgMenu.page == math.ceil(#images/6) then players[name].imgMenu.page = 1 else players[name].imgMenu.page = players[name].imgMenu.page + 1 end
        openMenu(name, players[name].imgMenu.page)
    elseif cb == "previousPage" then 
        if players[name].imgMenu.page == 1 then players[name].imgMenu.page = math.ceil(#images/6) else players[name].imgMenu.page = players[name].imgMenu.page - 1 end
        openMenu(name, players[name].imgMenu.page)
    elseif cb == "openchangelangue" then 
        openChangelanguage(name)
        flagButton(name, players[name].language , "closechangelangue", 45, 352)
    elseif cb == "closechangelangue" then 
        closeChangeLangue(name)
        flagButton(name, players[name].language , "openchangelangue", 45, 352)
    elseif cb == "openSettingsMenu" then 
        openSettingsMenu(name, 535, 75)
    elseif cb == "closeSettingsMenu" then
        closeSettingsMenu(name)
    elseif cb == "changingnick" then 
        if settings.nick ~= 0 then
            local cooldown = players[name].changenickCooldown
            if not cooldown or cooldown <= os.time() then
                ui.addPopup(2, 2, translate("nickC", name), name, 250, 200, 250, true)
            else
                local seconds = math.ceil((tonumber(cooldown) - os.time()) / 1000)
                TFM.chatMessage(string.format(translate("waitAMoment", name), seconds), name)
            end
        else
            TFM.chatMessage(string.format(translate("cantuse", name), translate("nick", name)), name)
        end
    elseif cb == "changingnickcolor" then 
        if settings.colornick ~= 0 then
            local cooldown = players[name].colornickCooldown
            if not cooldown or cooldown <= os.time() then
                ui.showColorPicker(1, name, 0xFFFFFF)
            else
                local seconds = math.ceil((tonumber(cooldown) - os.time()) / 1000)
                TFM.chatMessage(string.format(translate("waitAMoment", name), seconds), name)
            end
        else
            TFM.chatMessage(string.format(translate("cantuse", name), translate("colornick", name)), name)
        end
    elseif cb == "normalMouse" then
        if players[name].img then 
            players[name].character = nil
            TFM.removeImage(players[name].img)
            players[name].img = nil 
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
    for _, set in next, {[1] = {10 ,"sizelimit"}, [2] = {11 ,"fly"}, [3] = {12, "speed"}, [4] = {13, "colornick"}, [5] = {14, "nick"}} do 
        if cb == "change"..tostring(set[2]) then 
            if isAdmin(name) then
                ui.addPopup(set[1], 2, translate("change"..tostring(set[2]), name), name, 250, 200, 250, true)
            else
                local numb = settings[set[2]]
                if not numb or numb > 0 then
                    TFM.chatMessage(string.format(translate("use"..tostring(set[2]), name), numb), name)
                else
                    TFM.chatMessage(string.format(translate("cantuse", name), translate(set[2], name)), name)
                end
            end
        end
    end
    for pay in next, langue do 
        if cb == "changeto"..tostring(pay) then
            players[name].language = pay 
            closeChangeLangue(name)
            flagButton(name, players[name].language , "openchangelangue", 45, 352)
            playersInterface(name)
            TFM.chatMessage(translate("langchange", name), name)   
        end
    end
end

function decToHex(color)
    local b,k,out,i,d=16,"0123456789ABCDEF","",0
	while color>0 do
		i=i+1 color,d=math.floor(color/b),color%b+1 out=string.sub(k,d,d)..out
	end
    return out
end

function eventColorPicked(id, name, color)
    if id == 1 then 
        if color>0 then
            TFM.chatMessage(string.format(translate("chosencolor", name), decToHex(color), decToHex(color)), name)
            adminMessage("<pt>/colornick "..name.."<font color='#"..decToHex(color).."'> #"..decToHex(color).."</pt>")
            players[name].colornickCooldown = os.time() + (settings.colornick*1000)
        end
    end
end

function eventPopupAnswer(id , name, answer)
    if answer and answer ~= "" then
    local size = tonumber(answer)
        if id == 1 then
            if type(size) == "number" then
                if module.maxSize < size then size = settings.sizelimit elseif size < 0.1 then size = 0.1 end
                players[name].size = size
                TFM.changePlayerSize(name , players[name].size)
                updateImage(name)    
            end
        elseif id == 2 then
            TFM.chatMessage(string.format(translate("chosenName", name), answer), name)
            adminMessage("<pt>/changenick "..name.." "..answer.."</pt>")
            players[name].changenickCooldown = os.time() + (settings.nick*1000)
        end
        for n, set in next, {[1] = {10 ,"sizelimit"}, [2] = {11 ,"fly"}, [3] = {12, "speed"}, [4] = {13, "colornick"}, [5] = {14, "nick"}} do
            if id == set[1] then 
                if type(size) == "number" then 
                    if settings[set[2]] ~= size then
                        settings[set[2]] = size
                        openSettingsMenu(name, 535, 75)
                        if size ~= 0 then
                            translatedMessageForAll("changed"..set[2], size)
                            if set[2] =="sizelimit" then
                                updateSizeAll(size)
                                updateImageForAll()
                            end
                        elseif size == 0 and set[2] ~= "sizelimit" then
                            for player in next, playerList do
                                TFM.chatMessage(string.format(translate("cantuse", player), translate(tostring(set[2]), player)), player)
                            end
                        end
                    end
                end
            end
        end
    end
end

function eventKeyboard(name, k, d)
    if k == 0 then
        players[name].facingLeft = true
        if d then 
            updateImage(name)
            players[name].speed = true 
        else
            players[name].speed = false 
        end
    elseif k == 2 then
        players[name].facingLeft = false
        if d then 
            players[name].speed = true 
            updateImage(name)
        else
            players[name].speed = false 
        end
    elseif k == 32 then
        if settings.fly ~= 0 then 
            TFM.movePlayer(name, 0, 0, true, 0, -settings.fly)
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


function eventMovePlayers()
    if settings.speed ~= 0 then
        for name in next, playerList do 
            if players[name].speed and players[name].facingLeft then 
                TFM.movePlayer(name, 0, 0, true, -settings.speed, 0, true)
            elseif players[name].speed and not players[name].facingLeft then 
                TFM.movePlayer(name, 0, 0, true, settings.speed, 0, true)
            end
        end
    end
end


function eventNewGame()
    updateImageForAll()
end

function eventLoop()
    eventMovePlayers()
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
    TFM.chatMessage("<ROSE><B> • [SCRIPT]</B> Hi "..({pcall(nil)})[2]:match".-#%d+".." thanks you to active this script, hope you enjoy!</B></ROSE>", ({pcall(nil)})[2]:match".-#%d+")
end

main()
