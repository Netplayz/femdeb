# 🌸 FemDeb OS

<p align="center">
  <img src="branding/logo.svg" alt="FemDeb Logo" width="180"/>
</p>

<p align="center">
  <b>A cute, expressive, and powerful Debian-based Linux distribution with KDE Plasma.</b><br/>
  Built for people who want their desktop to feel like <i>them</i>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Base-Debian%2012%20Bookworm-pink?style=for-the-badge&logo=debian"/>
  <img src="https://img.shields.io/badge/Desktop-KDE%20Plasma-blue?style=for-the-badge&logo=kde"/>
  <img src="https://img.shields.io/badge/Status-In%20Development-ff69b4?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/License-GPL--3.0-purple?style=for-the-badge"/>
</p>

---

## ✨ What is FemDeb?

**FemDeb** is a custom Debian 12 "Bookworm"-based Linux distribution featuring KDE Plasma, designed to be expressive, aesthetic, and fully customizable out of the box. It comes pre-configured with a pastel-themed KDE environment, curated app defaults, and a cohesive visual identity.

---

## 🎀 Features

- 🐧 **Debian 12 (Bookworm)** base — stable, reliable, and massive software library
- 🖥️ **KDE Plasma 5** — the most customizable desktop environment on Linux
- 🌸 **FemDeb Theme** — custom pastel color scheme, icons, and wallpapers
- 🔒 **Calamares Installer** — friendly graphical installer for easy setup
- 🛠️ **Live ISO** — try before you install
- 📦 **Curated package set** — essentials pre-installed, nothing bloated
- 🎨 **Plymouth boot splash** — custom FemDeb branded boot screen

---

## 🗂️ Project Structure

```
femdeb/
├── .github/workflows/      # GitHub Actions CI (auto-build ISO)
├── config/
│   ├── archives/           # Custom APT repositories
│   ├── hooks/              # Build hooks (live & chroot)
│   ├── includes.chroot/    # Files to inject into the live system
│   ├── package-lists/      # APT package lists
│   └── preseed/            # Installer preseed configs
├── branding/               # Logos, wallpapers, color palette
├── scripts/                # Helper build/clean scripts
└── docs/                   # Documentation
```

---

## 🔧 Building FemDeb

### Prerequisites

You must build on a **Debian 12 (Bookworm)** system.

```bash
sudo apt update
sudo apt install live-build calamares git curl wget
```

### Clone & Build

```bash
git clone https://github.com/YOUR_USERNAME/femdeb.git
cd femdeb
chmod +x scripts/build.sh
sudo ./scripts/build.sh
```

The ISO will be output to `output/femdeb-*.iso`.

### Clean Build Artifacts

```bash
sudo ./scripts/clean.sh
```

---

## 🎨 Customization

### Changing the Theme
- KDE theme files → `config/includes.chroot/usr/share/femdeb/theme/`
- Wallpapers → `config/includes.chroot/usr/share/wallpapers/FemDeb/`
- Plymouth splash → `config/includes.chroot/usr/share/plymouth/themes/femdeb/`

### Adding/Removing Packages
- Edit `config/package-lists/femdeb.list.chroot`
- One package per line

### Custom Hooks
- Boot hooks → `config/hooks/live/`
- Chroot hooks (run at build time) → `config/hooks/normal/`

---

## 🤝 Contributing

Pull requests are welcome! Please open an issue first to discuss major changes.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## 📜 License

FemDeb is licensed under the **GNU General Public License v3.0**.  
See [LICENSE](LICENSE) for details.

---

<p align="center">Made with 💗 by the FemDeb project</p>
