--this is required to handle the locks control panel
minetest.register_on_player_receive_fields(function(player, formname, fields)
    local playername = player:get_player_name();
    if formname:find("locks_config:") then -- search if formname contains locks
        --minetest.chat_send_player(playername,dump(fields));
        local pos = minetest.string_to_pos(formname:gsub("locks_config:",""))
        if fields.ok then
            local data = locks:get_lockdata( pos )
            data.allowed_users = fields.allowed_users:gsub("\n",",");
            --data.password = fields.password;
            locks:set_lockdata( pos, data )
            --print("Player "..player:get_player_name().." submitted fields "..dump(fields))
        elseif fields.save_pw then
            local data = locks:get_lockdata( pos )
            data.password = fields.password;
            locks:set_lockdata( pos, data );
        elseif fields.pipeworks then
            local meta = minetest.get_meta(pos);
            if fields.pipeworks == "true" then
                meta:set_int( 'allow_pipeworks', 1 );
            else
                meta:set_int( 'allow_pipeworks', 0 );
            end
        end
        return true; --everything handled good :)

    elseif formname:find("locks_authorize:") then
        if fields.password and fields.password ~="" then
            local pos = minetest.string_to_pos(formname:gsub("locks_authorize:",""))
            local meta = minetest.get_meta(pos);
            if meta:get_string("password")==fields.password then
                locks.access_granted(playername, formname);
                meta:set_string("pw_user", playername)
            else
                locks.access_denied(playername, formname, true);

            end
        elseif fields.enter_password then --if the user clicks the "Enter Password" button in the "access denied" formspec
            locks.prompt_password(playername, formname);
        end

        return true --evrything is great :)
    end
    return false;
end)

-- craftitem; that can be used to craft shared locked objects
minetest.register_craftitem("locks:lock", {
    description = "Lock to lock and share objects",
    inventory_image = "locks_lock16.png",
});


minetest.register_craft({
    output = "locks:lock 2",
    recipe = {
        {'default:steel_ingot', 'default:steel_ingot','default:steel_ingot'},
        {'default:steel_ingot', '',                   'default:steel_ingot'},
        {'',                    'default:steel_ingot',''},
    }
});


-- a key allowes to open your own shared locked objects
minetest.register_craftitem("locks:key", {
    description = "Key to open your own shared locked objects",
    inventory_image = "locks_key32.png",
});

minetest.register_craft({
    output = "locks:key",
    recipe = {
        {'',                    'default:stick',      ''},
        {'',                    'default:steel_ingot',''},
    }
});



-- in order to open shared locked objects of other players, a keychain is needed (plus the owner has to admit it via /add playername or through /set password)
minetest.register_craftitem("locks:keychain", {
    description = "Keychain to open shared locked objects of others",
    inventory_image = "locks_keychain32.png",
});

minetest.register_craft({
    output = "locks:keychain",
    recipe = {
        {'',                    'default:steel_ingot', '' },
        {'locks:key',           'locks:key',           'locks:key'},
    }
});