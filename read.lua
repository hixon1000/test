local dfpwm = require("cc.audio.dfpwm")

local function play_sound(file_path)
    local speakers = table.pack(peripheral.find("speaker"))
    local decoder = dfpwm.make_decoder()

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

        parallel.waitForAll(table.unpack(funcs, 1, speakers.n))
    end
end
print("Playing disk 1")
play_sound("disk/Miku_aa")
print("Playing disk 2")
play_sound("disk2/Miku_ab")
print("Playing disk 3")
play_sound("disk3/Miku_ac")
print("Playing disk 4")
play_sound("disk4/Miku_ad")
print("Playing disk 5")
play_sound("disk5/Miku_ae")
print("Playing disk 6")
play_sound("disk6/Miku_af")
print("Playing disk 7")
play_sound("disk7/Miku_ag")
print("Playing disk 8")
play_sound("disk8/Miku_ah")
print("Playing disk 9")
play_sound("disk9/Miku_ai")
print("Playing disk 10")
play_sound("disk10/Miku_aj")
print("Playing disk 11")
play_sound("disk11/Miku_ak")
print("Playing disk 12")
play_sound("disk12/Miku_al")
