#!/usr/bin/env bash
# =============================================================================
#  FemDeb OS — Build Script
#  Builds a live Debian 12 ISO with KDE Plasma and FemDeb branding
# =============================================================================

set -euo pipefail

# ── Colors ────────────────────────────────────────────────────────────────────
PINK='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log()   { echo -e "${CYAN}[FemDeb]${NC} $*"; }
ok()    { echo -e "${GREEN}[  OK  ]${NC} $*"; }
err()   { echo -e "${RED}[ FAIL ]${NC} $*"; exit 1; }
banner(){ echo -e "${PINK}"; cat << 'EOF'
  ___           ____       _     
 |  _|___ _ __ |  _ \  ___| |__  
 | |_/ _ \ '_ \| | | |/ _ \ '_ \ 
 |  _  __/ | | | |_| |  __/ |_) |
 |_|  \___|_| |_|____/ \___|_.__/ 
                         🌸 OS Build System
EOF
echo -e "${NC}"; }

# ── Checks ────────────────────────────────────────────────────────────────────
check_root() {
  [[ $EUID -eq 0 ]] || err "This script must be run as root. Try: sudo ./scripts/build.sh"
}

check_deps() {
  log "Checking dependencies..."
  local deps=(live-build lb debootstrap)
  for dep in "${deps[@]}"; do
    command -v "$dep" &>/dev/null || err "Missing dependency: $dep — run: sudo apt install live-build"
  done
  ok "All dependencies present."
}

check_debian() {
  if ! grep -qi "debian" /etc/os-release 2>/dev/null; then
    err "FemDeb must be built on a Debian 12 (Bookworm) system."
  fi
  ok "Running on Debian — proceeding."
}

# ── Setup ─────────────────────────────────────────────────────────────────────
setup_lb() {
  log "Configuring live-build..."

  lb config \
    --distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --debian-installer live \
    --debian-installer-gui true \
    --bootloaders grub-efi \
    --binary-images iso-hybrid \
    --iso-application "FemDeb OS" \
    --iso-publisher "FemDeb Project" \
    --iso-volume "FemDeb" \
    --memtest none \
    --win32-loader false \
    --checksums sha256 \
    --compression xz \
    2>&1 | tee /tmp/femdeb-lb-config.log

  ok "live-build configured."
}

# ── Build ─────────────────────────────────────────────────────────────────────
build_iso() {
  log "Starting ISO build — this will take a while ☕"
  lb build 2>&1 | tee /tmp/femdeb-build.log
  ok "Build complete!"
}

# ── Output ────────────────────────────────────────────────────────────────────
collect_output() {
  local outdir="$(dirname "$0")/../output"
  mkdir -p "$outdir"
  local iso
  iso=$(find . -maxdepth 1 -name "*.iso" | head -1)
  if [[ -n "$iso" ]]; then
    local version
    version=$(date +%Y%m%d)
    mv "$iso" "$outdir/femdeb-${version}-amd64.iso"
    sha256sum "$outdir/femdeb-${version}-amd64.iso" > "$outdir/femdeb-${version}-amd64.iso.sha256"
    ok "ISO saved to: $outdir/femdeb-${version}-amd64.iso"
  else
    err "No ISO found after build. Check /tmp/femdeb-build.log for errors."
  fi
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  banner
  log "FemDeb OS Build System starting..."

  check_root
  check_debian
  check_deps

  # Change to project root
  cd "$(dirname "$0")/.."

  setup_lb
  build_iso
  collect_output

  echo ""
  echo -e "${PINK}🌸 FemDeb build complete! Find your ISO in the output/ directory. 🌸${NC}"
}

main "$@"
