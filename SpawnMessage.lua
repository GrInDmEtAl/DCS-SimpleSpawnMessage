spawnmsg = {}
spawnmsg.message = "" -- Mensagem global que será enviada

-- Handler de eventos
spawnmsg.eventHandler = {}

function spawnmsg.eventHandler:onEvent(event)
    local status, err = pcall(function()
        -- Validações iniciais
        if not event or not event.initiator then return end

        -- Evento de jogador entrando em unidade
        if event.id == world.event.S_EVENT_PLAYER_ENTER_UNIT then
            local unitName = event.initiator:getName()
            if unitName and spawnmsg.message ~= "" then
                spawnmsg.displayMessageToGroup(event.initiator, spawnmsg.message, 20, false)
            end
        end
    end)

    if not status then
        env.error(string.format("Erro ao tratar evento: %s", err), false)
    end
end

-- Obtém o ID do grupo baseado na unidade
function spawnmsg.getGroupId(unit)
    local unitId = tonumber(unit:getID())
    local unitDB = mist.DBs.unitsById[unitId]
    return unitDB and unitDB.groupId or nil
end

-- Exibe mensagem para o grupo da unidade
function spawnmsg.displayMessageToGroup(unit, text, duration, clear)
    local groupId = spawnmsg.getGroupId(unit)
    if groupId then
        trigger.action.outTextForGroup(groupId, text, duration or 10, clear or false)
    else
        env.warning(string.format("Grupo não encontrado para unidade: %s", unit:getName()), false)
    end
end

-- Adiciona o event handler ao mundo
world.addEventHandler(spawnmsg.eventHandler)

env.info("Spawn Message Handler ativo e pronto.")
