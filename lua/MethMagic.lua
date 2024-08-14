local muriaticAcidCodes = {
    'pln_rt1_20', -- Cook Off
    'pln_rat_stage1_20', -- Rats
    'Play_loc_mex_cook_03', -- Border Crystals
}

local causticSodaCodes = {
    'pln_rt1_22', -- Cook Off
    'pln_rat_stage1_22', -- Rats
    'Play_loc_mex_cook_04' -- Border Crystals
}

local hydrogenChlorideCodes = {
    'pln_rt1_24', -- Cook Off
    'pln_rat_stage1_24', -- Rats
    'Play_loc_mex_cook_05' -- Border Crystals
}

local batchFinishedCodes = {
    'pln_rt1_28', -- Cook Off
    'pln_rat_stage1_28', -- Rats
    'Play_loc_mex_cook_17', -- Border Crystals
    'Play_loc_mex_cook_13' -- Border Crystals
}

local totalBags = 0

if DialogManager ~= nil then

    local original_queue_dialog = DialogManager.queue_dialog
	
    -- Triggers every time there is dialogue
    function DialogManager:queue_dialog(id, ...)

        local isModEnabled = MethMagic._config.enabled_toggle == true
        if not isModEnabled then
			return original_queue_dialog(self, id, ...)
        end

        if containsCode(muriaticAcidCodes, id) then
            managers.chat:send_message(1, '[MethMagic]', 'Add ingredient: Muriatic Acid', Color.yellow)
        elseif containsCode(causticSodaCodes, id) then
            managers.chat:send_message(1, '[MethMagic]', 'Add ingredient: Caustic Soda', Color.yellow)
        elseif containsCode(hydrogenChlorideCodes, id) then
            managers.chat:send_message(1, '[MethMagic]', 'Add ingredient: Hydrogen Chloride', Color.yellow)
        elseif containsCode(batchFinishedCodes, id) then
            totalBags = totalBags + 1
            managers.chat:send_message(1, '[MethMagic]', 'Batch finished. Bags count: (' .. totalBags .. ')', Color.green)
        end

        return original_queue_dialog(self, id, ...)
    end
end

function containsCode(arr, code)
    for _, c in ipairs(arr) do
        if c == code then
            return true
        end
    end
    return false
end
