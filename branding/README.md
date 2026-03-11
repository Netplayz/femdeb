# FemDeb Branding Assets

This folder holds visual branding assets for FemDeb OS.

## Required Files

| File | Location | Description |
|------|----------|-------------|
| `logo.svg` | `branding/` | Main vector logo |
| `logo.png` | `branding/` | Rasterized logo (512x512) |
| `wallpaper-default.png` | `branding/wallpapers/` | Default KDE wallpaper (1920x1080+) |
| `sddm-bg.png` | `branding/` | SDDM login screen background |

## Plymouth Boot Assets

Place these in `config/includes.chroot/usr/share/plymouth/themes/femdeb/`:

| File | Size | Description |
|------|------|-------------|
| `background.png` | Full screen | Boot splash background |
| `logo.png` | ~300x300 | Center logo on splash |
| `progress-bg.png` | 1x6 | Progress bar track (dark) |
| `progress-fill.png` | 1x6 | Progress bar fill (pink accent) |

## Color Palette

| Name | Hex | Use |
|------|-----|-----|
| Petal Pink | `#F1D5E4` | Primary background |
| Rose Accent | `#DC8FB8` | Accent / highlights |
| Deep Plum | `#5C2A48` | Text / headers |
| Soft Lavender | `#E8D5F5` | Secondary background |
| Mint Whisper | `#D5F0E8` | Tertiary / hover |

## Adding Wallpapers

Drop `.jpg` or `.png` files into:
```
config/includes.chroot/usr/share/wallpapers/FemDeb/
```

KDE Plasma will auto-discover them in the wallpaper picker.
