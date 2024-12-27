local PlayerInLoadingScreen = false

---@param teleportPosition vector4
---@param WaitTime number
function Transition(teleportPosition, WaitTime)
    if PlayerInLoadingScreen == false then
        if WaitTime <= 2000 then
            WaitTime = 2000
        elseif WaitTime >= 2001 then
            WaitTime = WaitTime
        else
            WaitTime = 2000
        end
        PlayerInLoadingScreen = true
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
        if not IsPlayerSwitchInProgress() then
            SwitchOutPlayer(PlayerPedId(), 0, 1)
        end

        while GetPlayerSwitchState() ~= 5 do
            Citizen.Wait(0)
        end

        ShutdownLoadingScreen()

        SetEntityCoords(PlayerPedId(), teleportPosition.x, teleportPosition.y, teleportPosition.z, false, false, false, true)
        SetEntityHeading(PlayerPedId(), teleportPosition.w)

        ShutdownLoadingScreenNui()

        local timer = GetGameTimer()
        while true do
            Citizen.Wait(0)
            HideHudAndRadarThisFrame()
            SetDrawOrigin(0.0, 0.0, 0.0, 0)

            if GetGameTimer() - timer > WaitTime then
                SwitchInPlayer(PlayerPedId())

                while GetPlayerSwitchState() ~= 12 do
                    Citizen.Wait(0)
                    
                    HideHudAndRadarThisFrame()
                    SetDrawOrigin(0.0, 0.0, 0.0, 0)
                    SetGameplayCamRelativeHeading(0.0)
                end
                break
            end
        end
        PlayerInLoadingScreen = false
        ClearDrawOrigin()
    end
end
exports("Transition", Transition)

RegisterNetEvent('0xHud:Transition')
AddEventHandler('0xHud:Transition', function(teleportPosition, WaitTime)
    Transition(teleportPosition, WaitTime)
end)

