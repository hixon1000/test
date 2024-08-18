local dfpwm = require("cc.audio.dfpwm")
local function play_sound(file_path)
    local speaker = peripheral.find("speaker")

    local decoder = dfpwm.make_decoder()
    for chunk in io.lines(file_path, 16 * 1024) do
        local buffer = decoder(chunk)
        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end
play_sound("/disk/chunk_aa")
play_sound("/disk2/chunk_ab")
play_sound("/disk3/chunk_ac")
play_sound("/disk4/chunk_ad")
play_sound("/disk5/chunk_ae")
play_sound("/disk6/chunk_af")
