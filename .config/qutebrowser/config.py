import os
import catppuccin

config.load_autoconfig(True)

catppuccin.setup(c, "mocha", True)

homeDir = os.path.expanduser('~')
downDir = os.path.join(homeDir, 'Downloads')

config.set("zoom.default", "125%")
config.set("statusbar.padding", { "bottom": 2, "left": 0, "right": 0, "top": 0 })

# Tabs
config.set("tabs.position", "right")
config.set("tabs.favicons.scale", 0.8)
config.set("tabs.show", "switching")
config.set("tabs.show_switching_delay", 1400)
config.set("tabs.title.format_pinned", "{audio}{index}: {current_title}")

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
config.set("fonts.default_size", "13pt")
config.set("fonts.statusbar", "13pt Monolisa Trial")
config.set("fonts.tabs.selected", "13pt Monolisa Trial")
config.set("fonts.tabs.unselected", "13pt Monolisa Trial")
config.set("fonts.hints", "13pt Monolisa Trial")
config.set("fonts.completion.entry", "13pt Monolisa Trial")
config.set("fonts.completion.category", "13pt Monolisa Trial")

# Key bindings
config.bind("<space>Q", "quit")
config.bind("<space>r", "config-source ;; message-info 'Reloaded!'")
config.bind("<space><space>", "clear-messages")
config.bind("<space>m", "spawn bash -c \"yt-dlp --cookies-from-browser firefox --limit-rate 70K -f 18 -o - {url} | mpv -\"")
config.bind("<space>d", "spawn bash -c \"yt-dlp --cookies-from-browser firefox -f 18 -o '" + downDir + "/%(title)s.%(ext)s' '{url}'\"")
config.bind("<space>h", "spawn bash -c \"yt-dlp --cookies-from-browser firefox -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o '" + downDir + "/%(title)s.%(ext)s' '{url}'\"")
config.bind("<space>a", "spawn bash -c \"yt-dlp --cookies-from-browser firefox -f 140/250 -o '" + downDir + "/%(title)s.%(ext)s' '{url}'\"")
config.bind("q", "nop")

# Spell check
config.set("spellcheck.languages", [ "en-US" ])

# Brave adblock
config.set("content.blocking.method", "both")
