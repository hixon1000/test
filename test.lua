local url = "http://example.com/largefile.mp3" -- Replace with the actual file URL
local chunkSize = 100 * 1024 -- Smaller chunk size for each read (100 KB)
local totalSize = 1900 * 1024 -- Total size of the file (2 MB in this example)
local folderMap = {}
for i=1,18 do folderMap[i] = "disk" .. tostring(i+1) end


local function downloadChunk(startByte, endByte, chunkNum)
    local response = http.get(url, {
        ["Range"] = "bytes=" .. startByte .. "-" .. endByte
    })

    if response then
        local folderName = folderMap[chunkNum]
        if folderName then
            fs.makeDir(folderName)
            local filePath = fs.combine(folderName, "chunk_" .. chunkNum .. ".part")
            local file = fs.open(filePath, "wb")
            
            if file then
                local bytesRead = 0
                repeat
                    local data = response.read(chunkSize)
                    if data then
                        file.write(data)
                        bytesRead = bytesRead + #data
                    end
                until not data or bytesRead >= (endByte - startByte + 1)

                file.close()
                print("Chunk " .. chunkNum .. " saved successfully.")
            else
                print("Failed to open file for writing: " .. filePath)
            end
        else
            print("No folder specified for chunk " .. chunkNum)
        end
        response.close()
    else
        print("Failed to download chunk " .. chunkNum)
    end
end

local function downloadFileInChunks()
    local chunks = math.ceil(totalSize / chunkSize)
    
    for i = 1, chunks do
        local startByte = (i - 1) * chunkSize
        local endByte = math.min(i * chunkSize - 1, totalSize - 1)
        downloadChunk(startByte, endByte, i)
    end

    print("File download process complete.")
end

downloadFileInChunks()
