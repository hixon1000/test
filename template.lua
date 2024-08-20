local dfpwm = require("cc.audio.dfpwm")

local function play_sound(file_path)
    local speakers = table.pack(peripheral.find("speaker"))
    local decoder = dfpwm.make_decoder()

    -- Verify speakers
    for i = 1, speakers.n do
        print("Speaker " .. i .. ": " .. tostring(speakers[i]))
    end

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

        -- Test initialization and playback
        parallel.waitForAll(table.unpack(funcs, 1, speakers.n))
    end
end


-- Example usage:
play_sound("disk/bad_aa")

