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
