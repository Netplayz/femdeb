#!/usr/bin/env bash
# =============================================================================
#  FemDeb OS — Clean Script
#  Removes live-build artifacts and cache
# =============================================================================

set -euo pipefail

PINK='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

[[ $EUID -eq 0 ]] || { echo "Run as root: sudo ./scripts/clean.sh"; exit 1; }

echo -e "${CYAN}[FemDeb]${NC} Cleaning build artifacts..."
cd "$(dirname "$0")/.."

lb clean --all 2>/dev/null || true
rm -f *.iso *.hybrid.iso *.log
rm -rf output/ chroot/ binary/ cache/

echo -e "${PINK}🌸 Clean complete!${NC}"
