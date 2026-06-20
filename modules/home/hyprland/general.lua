-- Monitors
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@360",
    position = "0x0",
    scale    = "1",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.config({
    -- Disable builtin wallpapers
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo   = true,
    },

    dwindle = {
        preserve_split = true, -- You probably want this
    },
})
