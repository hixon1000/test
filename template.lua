local dfpwm = require("cc.audio.dfpwm")

local function delay_playback(start_time)
    while os.clock() < start_time do
        os.pullEvent("timer")
    end
end

local function play_sound(file_path)
    local all_speakers = table.pack(peripheral.find("speaker"))
    local speakers = table.pack(all_speakers[1], all_speakers[2])
    local decoder = dfpwm.make_decoder()

    for chunk in io.lines(file_path, 16 * 1024) do
        local buffer = decoder(chunk)
        local start_time = os.clock() + 0.1 -- 100ms delay

        -- Function to play audio on all speakers
        local function play_audio_on_all_speakers()
            local funcs = {}
            for i = 1, speakers.n do
                funcs[i] = function()
                    delay_playback(start_time)
                    while not speakers[i].playAudio(buffer) do
                        os.pullEvent("speaker_audio_empty")
                    end
                end
            end
            parallel.waitForAll(table.unpack(funcs, 1, speakers.n))
        end

        play_audio_on_all_speakers()
    end
end


-- Example usage:
play_sound("disk/bad_aa")

