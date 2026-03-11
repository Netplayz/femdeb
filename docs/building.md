# Building FemDeb OS

## System Requirements

- **OS:** Debian 12 "Bookworm" (must match target)
- **RAM:** 4 GB minimum, 8 GB recommended
- **Disk:** 20 GB free space for build artifacts
- **Internet:** Required to download packages during build

## Quick Start

```bash
# 1. Install build tools
sudo apt update
sudo apt install live-build git curl wget

# 2. Clone the repo
git clone https://github.com/YOUR_USERNAME/femdeb.git
cd femdeb

# 3. Make scripts executable
chmod +x scripts/*.sh

# 4. Build
sudo ./scripts/build.sh
```

The final ISO lands in `output/femdeb-YYYYMMDD-amd64.iso`.

---

## What live-build Does

`live-build` is Debian's official toolchain for creating live media. FemDeb uses it to:

1. **Bootstrap** a minimal Debian Bookworm system (`lb bootstrap`)
2. **Chroot** into it and install all packages (`lb chroot`)
3. **Run hooks** to apply FemDeb customizations
4. **Build binary** — packs the chroot into a squashfs and wraps it as an ISO (`lb binary`)

---

## Customizing the Build

### Package Lists

Add or remove packages from:
- `config/package-lists/femdeb.list.chroot` — core FemDeb packages
- `config/package-lists/kde.list.chroot` — KDE Plasma packages

One package name per line. Lines starting with `#` are comments.

### Custom Files

Any file under `config/includes.chroot/` is copied verbatim into the live system at the matching path. For example:
- `config/includes.chroot/etc/hostname` → `/etc/hostname` in the live system

### Hooks

Hooks are shell scripts that run during the build:
- `config/hooks/normal/*.hook.chroot` — run inside the chroot (at build time)
- `config/hooks/live/*.hook.chroot` — run at first boot of the live environment

Scripts must be executable (`chmod +x`).

---

## Building in GitHub Actions

Push to `main` or create a tag like `v1.0` to trigger the automated build. See `.github/workflows/build.yml`.

**Releases:** Tag a commit with a version (e.g., `git tag v1.0 && git push --tags`) to create a GitHub Release with the ISO attached.

---

## Flashing to USB

```bash
# Replace /dev/sdX with your USB device (check with lsblk)
sudo dd if=output/femdeb-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
```

> ⚠️ This will erase all data on the USB drive.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `lb` command not found | `sudo apt install live-build` |
| Build fails on package download | Check internet, try again or use a mirror |
| ISO won't boot | Re-flash USB with `dd` or try a different USB port |
| KDE doesn't start | Check GPU drivers — add your driver to the package list |
