
---@param BALANCE number
function SetCash(BALANCE)
    N_0x170f541e1cadd1de(true)
    StatSetInt(`MP0_WALLET_BALANCE`, tonumber(BALANCE), false)
    SetMultiplayerWalletCash()
    N_0x170f541e1cadd1de(false)

    Wait(3000);

    RemoveMultiplayerWalletCash()
end
exports("SetCash", SetCash)

RegisterNetEvent('0xHud:SetCash')
AddEventHandler('0xHud:SetCash', function(BALANCE)
    SetCash(BALANCE)
end)



---@param BALANCE number
function SetBank(BALANCE)
    N_0x170f541e1cadd1de(true)
    StatSetInt(`BANK_BALANCE`, tonumber(BALANCE), false)
    SetMultiplayerBankCash()
    N_0x170f541e1cadd1de(false)

    Wait(3000)

    RemoveMultiplayerBankCash()
end
exports("SetBank", SetBank)

RegisterNetEvent('0xHud:SetBank')
AddEventHandler('0xHud:SetBank', function(BALANCE)
    SetBank(BALANCE)
end)


local chips = 0

---@param BALANCE number
function SetChips(BALANCE)
    local scale = RequestScaleformScriptHudMovie(21)
    while not HasScaleformScriptHudMovieLoaded(21) do
        Citizen.Wait(0)
    end
    BeginScaleformScriptHudMovieMethod(21, "SET_PLAYER_CHIPS")
    ScaleformMovieMethodAddParamInt(BALANCE)
    EndScaleformMovieMethod()

    if BALANCE ~= chips then
        local bool = true
        local change = BALANCE - chips
        if BALANCE < chips then
            bool = false
            change = change * -1
        end

        local scale = RequestScaleformScriptHudMovie(22)
        while not HasScaleformScriptHudMovieLoaded(22) do
            Citizen.Wait(0)
        end
        BeginScaleformScriptHudMovieMethod(22, "SET_PLAYER_CHIP_CHANGE")
        ScaleformMovieMethodAddParamInt(change)
        ScaleformMovieMethodAddParamBool(bool)
        EndScaleformMovieMethod()
    end

    Citizen.Wait(4000)

    RemoveScaleformScriptHudMovie(21)
    RemoveScaleformScriptHudMovie(22)
    chips = BALANCE
end
exports("SetChips", SetChips)

RegisterNetEvent('0xHud:SetChips')
AddEventHandler('0xHud:SetChips', function(BALANCE)
    SetChips(BALANCE)
end)

---@param Stars number
function SetWanted(Stars)
    if Stars > 6 then
        SetFakeWantedLevel(6)
    elseif Stars < 0 then
        SetFakeWantedLevel(0)
    else
        SetFakeWantedLevel(Stars)
    end
end
exports("SetWanted", SetWanted)

RegisterNetEvent('0xHud:SetWanted')
AddEventHandler('0xHud:SetWanted', function(Stars)
    SetWanted(Stars)
end)

---@param message string
---@param isImportant boolean
function SendSimpleNotification(message, isImportant)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(isImportant, true)
end
exports("SendSimpleNotification", SendSimpleNotification)

RegisterNetEvent('0xHud:SendSimpleNotification')
AddEventHandler('0xHud:SendSimpleNotification', function(message, isImportant)
    SendSimpleNotification(message, isImportant)
end)

---@param title string
---@param subTitle string
---@param pngHash string
---@param message string
---@param isImportant boolean
function SendAdvancedNotification(title, subTitle, pngHash, message, isImportant)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(tostring(message))
    SetNotificationMessage(pngHash, pngHash, false, 1, tostring(title), tostring(subTitle))
    DrawNotification(isImportant, true)
end
exports("SendAdvancedNotification", SendAdvancedNotification)

RegisterNetEvent('0xHud:SendAdvancedNotification')
AddEventHandler('0xHud:SendAdvancedNotification', function(title, subTitle, pngHash, message, isImportant)
    SendAdvancedNotification(title, subTitle, pngHash, message, isImportant)
end)

---@param text string
---@param beep boolean
---@param duration number in second
function SendHelpText(text, beep, duration)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, beep, tonumber(duration * 1000))    
end
exports("SendHelpText", SendHelpText)

RegisterNetEvent('0xHud:SendHelpText')
AddEventHandler('0xHud:SendHelpText', function(text, beep, duration)
    SendHelpText(text, beep, duration)
end)

---@param text string
---@param duration number -- time in milliseconds
---@param drawImmediately boolean
function SendPrintText(text, duration, drawImmediately)
    BeginTextCommandPrint("STRING")
    AddTextComponentString(text)
    EndTextCommandPrint(duration, drawImmediately)
end
exports("SendPrintText", SendPrintText)

RegisterNetEvent('0xHud:SendPrintText')
AddEventHandler('0xHud:SendPrintText', function(text, duration, drawImmediately)
    SendPrintText(text, duration, drawImmediately)
end)

---@param action boolean
---@param text string
---@param type number -- Possible values: 1-5 for different types of spinners
function Spinner(action, text, type)
    if action == "true" or action == true then
        BeginTextCommandBusyString("STRING")
        AddTextComponentString(tostring(text))
        EndTextCommandBusyString(tonumber(type)) 
    elseif action == "false" or action == false then
        RemoveLoadingPrompt()
    else
        if Config.Debug then
            print("ERROR: action is wrong. action: " .. tostring(action))
        end
    end
end
exports("Spinner", Spinner)

RegisterNetEvent('0xHud:Spinner')
AddEventHandler('0xHud:Spinner', function(action, text, type)
    Spinner(action, text, type)
end)


---@param title string
---@param lastProgress number
---@param newProgress number
---@param isImportant boolean
function SkillsNotify(title, lastProgress, newProgress, isImportant)
    local handle = RegisterPedheadshot(PlayerPedId())
    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Citizen.Wait(0)
    end
    local txd = GetPedheadshotTxdString(handle)

    BeginTextCommandThefeedPost("PS_UPDATE")
    AddTextComponentInteger(newProgress)
    
    AddTextEntry("registered_text_for_Title_SkillsNotify_ab", title)

    local p1 = 14
    local unknownBool = false
    EndTextCommandThefeedPostStats("registered_text_for_Title_SkillsNotify_ab", p1, newProgress, lastProgress, unknownBool, txd, txd)

    local blink = false
    EndTextCommandThefeedPostTicker(blink, isImportant)
    UnregisterPedheadshot(handle)
end
exports("SkillsNotify", SkillsNotify)

RegisterNetEvent('0xHud:SkillsNotify')
AddEventHandler('0xHud:SkillsNotify', function(title, lastProgress, newProgress, isImportant)
    SkillsNotify(title, lastProgress, newProgress, isImportant)
end)

---@param title string
---@param subTitle string
---@param XP number
function SendXpNotify(title, subTitle, XP)
    local handle = RegisterPedheadshot(PlayerPedId())
    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Citizen.Wait(0)
    end
    local txd = GetPedheadshotTxdString(handle)

    local XP = XP

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(subTitle)
    AddTextEntry("registered_text_for_Title_ab", title)
    EndTextCommandThefeedPostAward(txd, txd, XP, 0, "registered_text_for_Title_ab")
    
    UnregisterPedheadshot(handle)
end
exports("SendXpNotify", SendXpNotify)

RegisterNetEvent('0xHud:SendXpNotify')
AddEventHandler('0xHud:SendXpNotify', function(title, subTitle, XP)
    SendXpNotify(title, subTitle, XP)
end)


function GetNextRank(CurrentRank)
    for k, v in pairs(Config.RanksAndXP) do
      if k == CurrentRank then
        local nextRank, NextXp = next(Config.RanksAndXP, k)
        return nextRank, NextXp, k, v
      end
    end
end

---@param currentXPLimit number
---@param AddXP number
---@param rank number
---@param onScreenDuration number -- Duration in seconds
---@param customColor number
function SetRankAndXP(currentXPLimit, AddXP, rank, onScreenDuration, customColor)
    -- local currentXPLimit = 4514
    -- local nextXPLimit  = 8428
    -- local playersPreviousXP = currentXPLimit  -- Last player XP
    -- local NewXP = 35000  -- NewXP
    -- local rank = 2  -- Current rank
    -- local onScreenDuration = 1000
    -- local customColor = 180
    -- SetRankAndXP(currentRankLimit, nextRankLimit, playersPreviousXP, playersCurrentXP, rank, onScreenDuration, customColor)

    local myAlpha = 100

    while not HasScaleformScriptHudMovieLoaded(19) do
        RequestScaleformScriptHudMovie(19)
        Citizen.Wait(200)
    end

    BeginScaleformScriptHudMovieMethod(19, "OVERRIDE_ANIMATION_SPEED")
    ScaleformMovieMethodAddParamInt(1625)
    EndScaleformMovieMethod()

    local adding = AddXP + currentXPLimit
    local NextRank1, NextXP1, oldRank1, oldXp1 = GetNextRank(rank)
    BeginScaleformScriptHudMovieMethod(19, "SET_RANK_SCORES")
    ScaleformMovieMethodAddParamInt(currentXPLimit)
    ScaleformMovieMethodAddParamInt(NextXP1)
    ScaleformMovieMethodAddParamInt(oldXp1)
    ScaleformMovieMethodAddParamInt(adding)
    ScaleformMovieMethodAddParamInt(rank)
    ScaleformMovieMethodAddParamInt(myAlpha)
    EndScaleformMovieMethod()

    BeginScaleformScriptHudMovieMethod(19, "SET_COLOUR")
    ScaleformMovieMethodAddParamInt(customColor)
    EndScaleformMovieMethod()

    Wait(950)

    local counter = 0
    local NextRank, NextXP, oldRank, oldXp = GetNextRank(rank)
    while adding >= NextXP do
        counter = counter + 1
        local NextRank2, NextXP2, oldRank, oldXp = GetNextRank(NextRank)
        BeginScaleformScriptHudMovieMethod(19, "SET_RANK_SCORES")
        ScaleformMovieMethodAddParamInt(oldXp)
        ScaleformMovieMethodAddParamInt(NextXP2)
        ScaleformMovieMethodAddParamInt(oldXp1)
        ScaleformMovieMethodAddParamInt(adding)
        ScaleformMovieMethodAddParamInt(NextRank)
        ScaleformMovieMethodAddParamInt(myAlpha)
        EndScaleformMovieMethod()
        NextRank, NextXP, oldRank, oldXp = GetNextRank(NextRank)
        Wait(1150)
        if Config.RanksAndXPSound == true then
            PlaySoundFrontend(-1, "RANK_UP", "HUD_AWARDS", 1)
        end
    end

    Wait(onScreenDuration * 1000)
    RemoveScaleformScriptHudMovie(19)
end
exports("SetRankAndXP", SetRankAndXP)

RegisterNetEvent('0xHud:SetRankAndXP')
AddEventHandler('0xHud:SetRankAndXP', function(currentXPLimit, AddXP, rank, onScreenDuration, customColor)
    SetRankAndXP(currentXPLimit, AddXP, rank, onScreenDuration, customColor)
end)

---@param Title string
---@param Subtitle string
---@param TitleColor number
---@param backgroundColor number
---@param Duration number -- Duration in seconds
function ShowWinMessage(Title, Subtitle, TitleColor, backgroundColor, Duration)
    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)

    local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_CENTERED_MP_MESSAGE")
    PushScaleformMovieMethodParameterString(Title)
    PushScaleformMovieMethodParameterString(Subtitle)
    ScaleformMovieMethodAddParamInt(TitleColor)
    ScaleformMovieMethodAddParamInt(backgroundColor)
    PushScaleformMovieMethodParameterInt(Duration)
    EndScaleformMovieMethod()

    local displayTime = GetGameTimer() + (Duration * 1000)
    while GetGameTimer() < displayTime do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end

    SetScaleformMovieAsNoLongerNeeded(scaleform)
end
exports("ShowWinMessage", ShowWinMessage)

RegisterNetEvent('0xHud:ShowWinMessage')
AddEventHandler('0xHud:ShowWinMessage', function(Title, Subtitle, TitleColor, backgroundColor, Duration)
    ShowWinMessage(Title, Subtitle, TitleColor, backgroundColor, Duration)
end)

--- Race Countdown 
---@param r number min 0 max 255
---@param g number min 0 max 255
---@param b number min 0 max 255
---@return boolean -- return true when finish
function ShowRaceCountdown(r, g, b)
    if r and g and b then 
        local r, g, b = r, g, b
    else
        local r, g, b = 240, 200, 80
    end
    local isMP =  true
    local scaleform = RequestScaleformMovie("COUNTDOWN")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    
    PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
    BeginScaleformMovieMethod(scaleform, "SET_MESSAGE")
    ScaleformMovieMethodAddParamPlayerNameString(3)
    ScaleformMovieMethodAddParamInt(r)
    ScaleformMovieMethodAddParamInt(g)
    ScaleformMovieMethodAddParamInt(b)
    ScaleformMovieMethodAddParamBool(isMP)
    EndScaleformMovieMethod()

    local displayTime = GetGameTimer() + 1000
    while GetGameTimer() < displayTime do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end

    PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
    BeginScaleformMovieMethod(scaleform, "SET_MESSAGE")
    ScaleformMovieMethodAddParamPlayerNameString(2)
    ScaleformMovieMethodAddParamInt(r)
    ScaleformMovieMethodAddParamInt(g)
    ScaleformMovieMethodAddParamInt(b)
    ScaleformMovieMethodAddParamBool(isMP)
    EndScaleformMovieMethod() 
    
    local displayTime = GetGameTimer() + 1000
    while GetGameTimer() < displayTime do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end

    PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
    BeginScaleformMovieMethod(scaleform, "SET_MESSAGE")
    ScaleformMovieMethodAddParamPlayerNameString(1)
    ScaleformMovieMethodAddParamInt(r)
    ScaleformMovieMethodAddParamInt(g)
    ScaleformMovieMethodAddParamInt(b)
    ScaleformMovieMethodAddParamBool(isMP)
    EndScaleformMovieMethod()

    local displayTime = GetGameTimer() + 450
    while GetGameTimer() < displayTime do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end
    PlaySoundFrontend(-1, "GO", "HUD_MINI_GAME_SOUNDSET", 1)
    local displayTime = GetGameTimer() + 550
    while GetGameTimer() < displayTime do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end


    BeginScaleformMovieMethod(scaleform, "SET_MESSAGE")
    ScaleformMovieMethodAddParamPlayerNameString("Go!")
    ScaleformMovieMethodAddParamInt(r)
    ScaleformMovieMethodAddParamInt(g)
    ScaleformMovieMethodAddParamInt(b)
    ScaleformMovieMethodAddParamBool(isMP)
    EndScaleformMovieMethod()

    local displayTime = GetGameTimer() + 2000
    while GetGameTimer() < displayTime do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end
    SetScaleformMovieAsNoLongerNeeded(scaleform)
    return true
end
exports("ShowRaceCountdown", ShowRaceCountdown)

RegisterNetEvent('0xHud:ShowRaceCountdown')
AddEventHandler('0xHud:ShowRaceCountdown', function(r, g, b)
    ShowRaceCountdown(r, g, b)
end)

---comment
---@param Title string
---@param Desc strin
---@param Desc2 string
---@param displayTime number in seconds
function ShowUnlockMessage(Title, Desc, Desc2, displayTime)
    local scaleform = RequestScaleformMovie("mp_unlock_freemode")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    local txd = ""
    local texture = ""
    local colEnum = 25

    BeginScaleformMovieMethod(scaleform, "SHOW_UNLOCK_AND_MESSAGE")
    ScaleformMovieMethodAddParamPlayerNameString(Title)
    ScaleformMovieMethodAddParamPlayerNameString(Desc)
    ScaleformMovieMethodAddParamPlayerNameString(txd)
    ScaleformMovieMethodAddParamPlayerNameString(texture)
    ScaleformMovieMethodAddParamPlayerNameString(Desc2)
    ScaleformMovieMethodAddParamInt(colEnum)
    EndScaleformMovieMethod()

    Citizen.CreateThread(function()
        local displayTime = displayTime * 1000
        local currentTime = GetGameTimer()

        while GetGameTimer() - currentTime < displayTime do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
        SetScaleformMovieAsNoLongerNeeded(scaleform)
    end)
end
exports("ShowUnlockMessage", ShowUnlockMessage)

RegisterNetEvent('0xHud:ShowUnlockMessage')
AddEventHandler('0xHud:ShowUnlockMessage', function(Title, Desc, Desc2, displayTime)
    ShowUnlockMessage(Title, Desc, Desc2, displayTime)
end)



---@param Hide boolean
function ToggleBars(Hide)
    SendNUIMessage({
        hide = Hide,
    })
end
exports("ToggleBars", ToggleBars)

RegisterNetEvent('0xHud:ToggleBars')
AddEventHandler('0xHud:ToggleBars', function(Hide)
    ToggleBars(Hide)
end)

---@param bar string -- bars (`progress`, `circle`, `text`, `countdown`, `timerProgress`)
---@param id string
---@param label string
---@param action action
---@param color table
function CreateTimerBar(bar, id, label, action, color)
    SendNUIMessage({
        bar = bar,
        id = id,
        label = label,
        action = action,
        color = color
    })
end
exports("CreateTimerBar", CreateTimerBar)

RegisterNetEvent('0xHud:CreateTimerBar')
AddEventHandler('0xHud:CreateTimerBar', function(bar, id, label, action, color)
    CreateTimerBar(bar, id, label, action, color)
end)

function UpdateProgress(id, percentage)
    SendNUIMessage({
        action = "updateProgress",
        id = id,
        percentage = percentage,
    })
end
exports("UpdateProgress", UpdateProgress)

RegisterNetEvent('0xHud:UpdateProgress')
AddEventHandler('0xHud:UpdateProgress', function(id, percentage)
    UpdateProgress(id, percentage)
end)

function RemoveBar(id)
    SendNUIMessage({
        action = "removeBar",
        id = id,
    })
end
exports("RemoveBar", RemoveBar)

RegisterNetEvent('0xHud:RemoveBar')
AddEventHandler('0xHud:RemoveBar', function(id)
    RemoveBar(id)
end)

function UpdateText(id, text, color)
    SendNUIMessage({
        action = "updateText",
        id = id,
        text = text,
        color = color,
    })
end
exports("RemoveCircle", RemoveCircle)

RegisterNetEvent('0xHud:UpdateText')
AddEventHandler('0xHud:UpdateText', function(id, text, color)
    UpdateText(id, text, color)
end)

function UpdateCircle(id, circle, color, kill)
    SendNUIMessage({
        action = "updateCircle",
        id = id,
        circle = circle,
        color = color,
        kill = kill,
    })
end
exports("UpdateCircle", UpdateCircle)

RegisterNetEvent('0xHud:UpdateCircle')
AddEventHandler('0xHud:UpdateCircle', function(id, circle, color, kill)
    UpdateCircle(id, circle, color, kill)
end)

function RemoveCircle(id, circle)
    SendNUIMessage({
        action = "removeCircle",
        id = id,
        circle = circle,
    })
end
exports("RemoveCircle", RemoveCircle)

RegisterNetEvent('0xHud:RemoveCircle')
AddEventHandler('0xHud:RemoveCircle', function(id, circle)
    RemoveCircle(id, circle)
end)


RegisterCommand("test0xhud", function ()
    --SetRankAndXP(14872, 3000, 9, 5000, 26)
    --ShowWinMessage("Title", "Subtitle", 27, 25, 3)
    --ShowUnlockMessage("Title", "Desc", "Desc2", 3)
    --SendXpNotify("title", "subTitle", 200)
    --SendHelpText("text", true, 6)
    --SendAdvancedNotification("title", "subTitle", "pngHash", "message", true)
    --SetWanted(6)
end, false)