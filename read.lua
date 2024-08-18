local function play_sound(file_path)
    local speaker = peripheral.find("speaker")
    if speaker then
        local file = fs.open(file_path, "r")
        if file then
            local data = file.readAll()
            file.close()
            
            -- Play the sound data
            speaker.playSound(data)
            print("Playing sound from " .. file_path)
        else
            print("File not found: " .. file_path)
        end
    else
        print("No speaker found.")
    end
end
play_sound("/disk/chunk_aa")
play_sound("/disk2/chunk_ab")
play_sound("/disk3/chunk_ac")
play_sound("/disk4/chunk_ad")
play_sound("/disk5/chunk_ae")
play_sound("/disk6/chunk_af")
