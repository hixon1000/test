local dfpwm = require("cc.audio.dfpwm")

local function play_sound(file_path)
    -- Find all speakers
    local all_speakers = table.pack(peripheral.find("speaker"))
    
    -- Select only the first two unique speakers
    local speakers = table.pack(all_speakers[1], all_speakers[2])
    local decoder = dfpwm.make_decoder()

    -- Verify the speakers being used
    print("Number of speakers used: " .. speakers.n)
    for i = 1, speakers.n do
        print("Speaker " .. i .. ": " .. tostring(speakers[i]))
    end

    -- Play sound through the selected speakers
    for chunk in io.lines(file_path, 16 * 1024) do
        local buffer = decoder(chunk)
        local funcs = {}

        for i = 1, speakers.n do
            funcs[i] = function()
                while not speakers[i].playAudio(buffer) do
                    os.pullEvent("speaker_audio_empty")
                end
            end
        end

        -- Ensure synchronization across the selected speakers
        parallel.waitForAll(table.unpack(funcs, 1, speakers.n))
    end
end


-- Example usage:
play_sound("disk/bad_aa")

