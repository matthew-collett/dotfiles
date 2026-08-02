local source = os.getenv("HOME") .. "/docs/wallpapers/walls"
local current = os.getenv("HOME") .. "/docs/wallpapers/current"
local exts = { jpg = true, jpeg = true, png = true, webp = true }
local skip = { ["."] = true, [".."] = true, [".git"] = true, animated = true }

math.randomseed(os.time())

local function collectImages()
    local images = {}
    local function walk(dir)
        for name in hs.fs.dir(dir) do
            if not skip[name] then
                local path = dir .. "/" .. name
                local attrs = hs.fs.attributes(path)
                if attrs and attrs.mode == "directory" then
                    walk(path)
                elseif exts[(name:match("%.(%a+)$") or ""):lower()] then
                    images[#images + 1] = path
                end
            end
        end
    end
    walk(source)
    return images
end

local function rotate()
    local images = collectImages()
    if #images == 0 then
        hs.alert.show("Wallpaper: no images found in " .. source)
        return
    end

    local pick = images[math.random(#images)]
    local ext = pick:match("%.(%a+)$") or "jpg"

    hs.fs.mkdir(current)
    for name in hs.fs.dir(current) do
        if name:match("^wp_%d+%.%a+$") then
            os.remove(current .. "/" .. name)
        end
    end

    local dest = string.format("%s/wp_%d.%s", current, os.time(), ext)

    local src = io.open(pick, "rb")
    if not src then
        hs.alert.show("Wallpaper: failed to open " .. pick)
        return
    end
    local data = src:read("*a")
    src:close()

    local out = io.open(dest, "wb")
    if not out then
        hs.alert.show("Wallpaper: failed to write " .. dest)
        return
    end
    out:write(data)
    out:close()

    for _, scr in ipairs(hs.screen.allScreens()) do
        scr:desktopImageURL("file://" .. dest)
    end
end

local watcher = hs.caffeinate.watcher.new(function(e)
    if e == hs.caffeinate.watcher.screensDidUnlock then
        rotate()
    end
end)
watcher:start()

return {
    rotate = rotate,
    watcher = watcher,
}
