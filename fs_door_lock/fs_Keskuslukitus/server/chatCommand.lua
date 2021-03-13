if(globalConf["SERVER"].enableGiveKey)then
    RegisterCommand('givekey', function(source, args, rawCommand)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]

        if(args[1])then
            local targetId = args[1]
            local targetIdentifier = GetPlayerIdentifiers(targetId)[1]
            if(targetIdentifier)then
                if(targetIdentifier ~= identifier)then
                    if(args[2])then
                        local plate = string.lower(args[2])
                        if(owners[plate])then
                            if(owners[plate] == identifier)then
                                alreadyHas = false
                                for k, v in pairs(secondOwners) do
                                    if(k == plate)then
                                        for _, val in ipairs(v) do
                                            if(val == targetIdentifier)then
                                                alreadyHas = true
                                            end
                                        end
                                    end
                                end

                                if(not alreadyHas)then
                                    TriggerClientEvent("ls:giveKeys", targetIdentifier, plate)
                                    TriggerEvent("ls:addSecondOwner", targetIdentifier, plate)

                                    TriggerClientEvent("ls:notify", targetId, "Sinä vastaanotit ajoneuvon avaimet! " .. plate .. " henkilöltä " .. GetPlayerName(src))
                                    TriggerClientEvent("ls:notify", src, "Sinä annoit ajoneuvon avaimet " .. plate .. " pelaajalle " .. GetPlayerName(targetId))
                                else
                                    TriggerClientEvent("ls:notify", src, "Kohteelle kenelle olet antamassa avaimia, avaimet ovat jo hänellä!")
                                    TriggerClientEvent("ls:notify", targetId, GetPlayerName(src) .. " tried to give you his keys, but you already had them")
                                end
                            else
                                TriggerClientEvent("ls:notify", src, "Tämä ei ole sinun ajoneuvosi")
                            end
                        else
                            TriggerClientEvent("ls:notify", src, "Ajoneuvon rekisterinumero ei täsmää!")
                        end
                    else
                        TriggerClientEvent("ls:notify", src, "Anna henkilölle ajoneuvosi avaimet: /givekey <id> <rekisterinumero>")
                    end
                else
                    TriggerClientEvent("ls:notify", src, "Et voi antaa avaimia itsellesi!")
                end
            else
                TriggerClientEvent("ls:notify", src, "Pelaajaa ei löytynyt listalta...")
            end
        else
            TriggerClientEvent("ls:notify", src, 'First missing argument : /givekey <id> <rekisterinumero>')
        end

        CancelEvent()
    end)
end
