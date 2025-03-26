import catppuccin

config.load_autoconfig(True)

catppuccin.setup(c, "mocha", True)

config.set("zoom.default", "125%")
config.set("statusbar.padding", { "bottom": 2, "left": 0, "right": 0, "top": 0 })

# Tabs
config.set("tabs.position", "right")
config.set("tabs.favicons.scale", 0.8)
config.set("tabs.show", "switching")
config.set("tabs.show_switching_delay", 1400)
config.set("tabs.title.format_pinned", "{audio}*{index}*: {current_title}")

# Dark mode
config.set("colors.webpage.bg", "black")
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "never")
config.set("colors.webpage.darkmode.threshold.foreground", 168)
config.set("colors.webpage.darkmode.threshold.background", 88)
config.set("colors.webpage.preferred_color_scheme", "dark")

# Session management
config.set("auto_save.session", True)
config.set("session.lazy_restore", True)

# Search engines
config.set("url.searchengines", {
    "DEFAULT": "https://www.duckduckgo.com/search?q={}",
    "g": "https://www.google.com/search?q={}",
    "pkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged="
})

# Fonts
config.set("fonts.default_size", "14pt")
config.set("fonts.statusbar", "14pt Monolisa Trial")
config.set("fonts.tabs.selected", "14pt Monolisa Trial")
config.set("fonts.tabs.unselected", "14pt Monolisa Trial")
config.set("fonts.hints", "14pt Monolisa Trial")
config.set("fonts.completion.entry", "14pt Monolisa Trial")
config.set("fonts.completion.category", "14pt Monolisa Trial")

# Key bindings
config.bind("<space>r", "config-source ;; message-info "Reloaded!"")
config.bind("<space>h", "clear-messages")
config.bind("q", "nop")
