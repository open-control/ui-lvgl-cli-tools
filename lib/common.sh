#!/bin/bash
# Open Control UI LVGL CLI Tools - Shared utilities
# Source: source "$SCRIPT_DIR/../lib/common.sh"

set -e

# ═══════════════════════════════════════════════════════════════════
# Colors
# ═══════════════════════════════════════════════════════════════════
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
GRAY='\033[38;5;248m'
NC='\033[0m'

# ═══════════════════════════════════════════════════════════════════
# Logging
# ═══════════════════════════════════════════════════════════════════
log()     { echo -e "${CYAN}●${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}⚠${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1" >&2; exit 1; }

# ═══════════════════════════════════════════════════════════════════
# Project root detection (walks up from pwd to find platformio.ini)
# ═══════════════════════════════════════════════════════════════════
find_project_root() {
    local dir="${1:-$(pwd)}"
    while [[ "$dir" != "/" && ! -f "$dir/platformio.ini" ]]; do
        dir="$(dirname "$dir")"
    done
    [[ -f "$dir/platformio.ini" ]] && echo "$dir" || return 1
}
