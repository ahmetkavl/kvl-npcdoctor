KVL = {}


KVL.OX = true

KVL['Prices'] = {
    ['LegalPrice'] = 100,
    ['IllegalPrice'] = 1000
}

KVL['Doctors'] = {
    Legal = {
        ['Medical'] = {
            coords = vec3(299.8935, -582.720, 43.260),
            npc = {ped = 0xB353629E, anim = "", x = 299.8964, y = -582.744, z = 43.260, h = 69.863876342773},
        },
        -- ['mark'] = {
        --     coords = vec3(416.9166, -966.447, 29.445),                   -- If you want to activate a 2nd receiver, you can arrange them with the same logic.
        -- } 
    },
    Illegal = {
        ['baddoc'] = {
            coords = vec3(572.1038, 113.9595, 98.417),
            npc = {ped = 0x2DC6D3E7, anim = "WORLD_HUMAN_STAND_MOBILE", x = 572.1038, y = 113.9595, z = 98.180, h = 344.36471557617},
        },
        -- ['mark'] = {
        --     coords = vec3(416.9166, -966.447, 29.445),                   -- If you want to activate a 2nd receiver, you can arrange them with the same logic.
        -- } 
    },
}

KVL['Locales'] = {
    ['needmoney'] = 'You dont have enough money. You need: ',
}




