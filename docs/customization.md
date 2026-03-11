# Customizing FemDeb OS

## Theme & Appearance

### Color Scheme

FemDeb uses a pastel pink/lavender palette. Core colors are defined in:
- `config/hooks/live/0100-femdeb-live.hook.chroot` — KDE `kdeglobals` color overrides
- `branding/README.md` — full palette reference

### Wallpapers

Drop wallpaper images into:
```
config/includes.chroot/usr/share/wallpapers/FemDeb/
```
Supported formats: `.jpg`, `.png`, `.webp`

KDE Plasma's wallpaper picker will list them automatically.

### Icons

FemDeb includes **Papirus** icon theme by default. To change:
1. Add your preferred icon theme package to `config/package-lists/femdeb.list.chroot`
2. Update the `Icons` entry in `config/hooks/live/0100-femdeb-live.hook.chroot`

### SDDM Login Screen

SDDM configuration is in:
```
config/includes.chroot/etc/sddm.conf.d/femdeb.conf
```
To use a custom background, place your image at:
```
config/includes.chroot/usr/share/sddm/themes/femdeb/background.jpg
```

---

## KDE Plasma Defaults

Default KDE settings for new users are applied via the live hook. The primary config file is:
```
config/hooks/live/0100-femdeb-live.hook.chroot
```

This writes `~/.config/kdeglobals` for the live user. For permanent installs, Calamares will copy `/etc/skel/` to new user homes.

Skel directory: `config/includes.chroot/etc/skel/`

---

## Pre-installed Applications

Edit `config/package-lists/femdeb.list.chroot` to add or remove apps. Some key defaults:

| App | Purpose | Package |
|-----|---------|---------|
| Firefox ESR | Browser | `firefox-esr` |
| VLC | Media player | `vlc` |
| LibreOffice | Office suite | `libreoffice-*` |
| Konsole | Terminal | `konsole` |
| Dolphin | File manager | `dolphin` |
| Kate | Text editor | `kate` |

---

## Live User

The live session username and settings are configured in:
```
config/includes.chroot/etc/live/config.conf.d/femdeb.conf
```

Default credentials for the live session:
- **Username:** `femdeb`
- **Password:** `femdeb` (set by live-config)

---

## Boot Splash (Plymouth)

Plymouth theme files live in:
```
config/includes.chroot/usr/share/plymouth/themes/femdeb/
```

You need:
- `femdeb.plymouth` — descriptor file
- `femdeb.script` — Plymouth script
- `background.png` — full-screen background
- `logo.png` — centered logo
- `progress-bg.png` — progress bar track
- `progress-fill.png` — progress bar fill (1px wide, scales to width)

See `branding/README.md` for recommended sizes.

---

## Locale & Timezone

Set in `config/includes.chroot/etc/live/config.conf.d/femdeb.conf`:
```
LIVE_TIMEZONE="America/New_York"
LIVE_LOCALE="en_US.UTF-8"
```

Change these to match your preferred locale before building.
