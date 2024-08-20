local dfpwm = require("cc.audio.dfpwm")

local function play_sound(file_path)
    local speakers = table.pack(peripheral.find("speaker"))
    local decoder = dfpwm.make_decoder()

    -- Function to play a chunk on all speakers
    local function play_chunk_on_all_speakers(buffer)
        local all_speakers_ready = false
        while not all_speakers_ready do
            all_speakers_ready = true
            for i = 1, speakers.n do
                if not speakers[i].playAudio(buffer) then
                    all_speakers_ready = false
                    os.pullEvent("speaker_audio_empty")
                    break
                end
            end
        end
    end

    -- Iterate through the file and play each chunk
    for chunk in io.lines(file_path, 16 * 1024) do
        local buffer = decoder(chunk)
        play_chunk_on_all_speakers(buffer)
    end
end
