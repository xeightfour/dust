import os
import catppuccin

config.load_autoconfig(True)

catppuccin.setup(c, "mocha", True)

homeDir = os.path.expanduser("~")
downDir = os.path.join(homeDir, "Downloads")

config.set("zoom.default", "125%")

# Status bar
config.set("statusbar.padding", {"bottom": 2, "left": 0, "right": 0, "top": 2})

# Tabs
config.set("tabs.position", "right")
config.set("tabs.favicons.scale", 0.9)
config.set("tabs.show", "switching")
config.set("tabs.show_switching_delay", 1400)
config.set("tabs.title.format_pinned", "{audio}{index}: {current_title}")
config.set("tabs.padding", {"bottom": 2, "left": 5, "right": 5, "top": 2})

# Dark mode
config.set("colors.webpage.bg", "black")
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "smart")
config.set("colors.webpage.darkmode.threshold.foreground", 176)
config.set("colors.webpage.darkmode.threshold.background", 80)
config.set("colors.webpage.preferred_color_scheme", "dark")

# Session management
config.set("auto_save.session", True)
config.set("session.lazy_restore", True)

# Search engines
config.set(
    "url.searchengines",
    {
        "DEFAULT": "https://www.google.com/search?q={}",
        "g": "https://www.google.com/search?q={}",
        "pkg": (
            "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged="
        ),
    },
)

# Fonts
config.set("fonts.default_size", "13pt")
config.set("fonts.statusbar", "13pt Cascadia Code")
config.set("fonts.tabs.selected", "13pt Cascadia Code")
config.set("fonts.tabs.unselected", "13pt Cascadia Code")
config.set("fonts.hints", "13pt Cascadia Code")
config.set("fonts.completion.entry", "13pt Cascadia Code")
config.set("fonts.completion.category", "13pt Cascadia Code")

# Key bindings
config.bind("j", "cmd-run-with-count 4 scroll down")
config.bind("k", "cmd-run-with-count 4 scroll up")
config.bind("<space>r", "config-source ;; message-info 'Reloaded!'")
config.bind("<space><space>", "clear-messages")
config.bind("<ctrl-shift-j>", "tab-move +")
config.bind("<ctrl-shift-k>", "tab-move -")
config.bind("<space>Q", "quit")
config.bind(
    "<space>m",
    'spawn bash -c "yt-dlp --cookies-from-browser firefox --limit-rate 70K -f'
    " 18 -o - '{url}' | mpv -\"",
)
config.bind(
    "<space>d",
    "spawn bash -c \"yt-dlp --cookies-from-browser firefox -f 18 -o '"
    + downDir
    + "/%(title)s.%(ext)s' '{url}'\"",
)
config.bind(
    "<space>h",
    'spawn bash -c "yt-dlp --cookies-from-browser firefox -f'
    " 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o '"
    + downDir
    + "/%(title)s.%(ext)s' '{url}'\"",
)
config.bind(
    "<space>a",
    "spawn bash -c \"yt-dlp --cookies-from-browser firefox -f 140/250 -o '"
    + downDir
    + "/%(title)s.%(ext)s' '{url}'\"",
)
config.bind("q", "nop")

# Spell check
config.set("spellcheck.languages", ["en-US"])

# Brave ad-block
config.set("content.blocking.method", "both")
