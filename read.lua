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
play_sound("disk/bad_aa")
print("Playing disk 2")
play_sound("disk2/bad_ab")
print("Playing disk 3")
play_sound("disk3/bad_ac")
print("Playing disk 4")
play_sound("disk4/bad_ad")
print("Playing disk 5")
play_sound("disk5/bad_ae")
print("Playing disk 6")
play_sound("disk6/bad_af")
print("Playing disk 7")
play_sound("disk7/bad_ag")
print("Playing disk 8")
play_sound("disk8/bad_ah")
print("Playing disk 9")
play_sound("disk9/bad_ai")
print("Playing disk 10")
play_sound("disk10/bad_aj")
print("Playing disk 11")
play_sound("disk11/bad_ak")
print("Playing disk 12")
play_sound("disk12/bad_al")
print("Playing disk 13")
play_sound("disk13/bad_am")
print("Playing disk 14")
play_sound("disk14/bad_an")
print("Playing disk 15")
play_sound("disk15/bad_ao")
print("Playing disk 16")
play_sound("disk16/bad_ap")
