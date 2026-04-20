local json = require("json") -- You must provide this library
local soundSources = {}
local config = {}

function love.load()
    -- 1. Read the JSON file
    local content = love.filesystem.read("assets/effect.json")
    config = json.decode(content)

    -- 2. Pre-load all audio files into a table for instant playback
    for _, filename in ipairs(config.sources) do
        local source = love.audio.newSource(filename, "static")
        table.insert(soundSources, source)
    end

    -- Seed the random number generator
    math.randomseed(os.time())
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and #soundSources > 0 then
        -- 3. Pick a random index from our table
        local randomIndex = math.random(#soundSources)
        local selectedSound = soundSources[randomIndex]

        -- 4. Play the sound
        -- Note: If you click very fast, we "clone" it so sounds can overlap
        local playback = selectedSound:clone()
        playback:play()
    end
end
