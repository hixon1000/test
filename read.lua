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
print("Playing disk 1")
play_sound("/disk/chunk_aa")
print("Playing disk 2")
play_sound("/disk2/chunk_ab")
print("Playing disk 3")
play_sound("/disk3/chunk_ac")
print("Playing disk 4")
play_sound("/disk4/chunk_ad")
print("Playing disk 5")
play_sound("/disk5/chunk_ae")
print("Playing disk 6")
play_sound("/disk6/chunk_af")
print("Playing disk 7")
play_sound("/disk7/chunk_ag")
