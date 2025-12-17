#!/bin/bash
# Open Control UI LVGL CLI Tools - Install script (Linux/macOS)
# Adds ui-lvgl-cli-tools/bin to PATH in shell config

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"

# Detect shell config file
if [[ -n "$ZSH_VERSION" ]] || [[ "$SHELL" == *"zsh"* ]]; then
    RC_FILE="$HOME/.zshrc"
elif [[ -n "$BASH_VERSION" ]] || [[ "$SHELL" == *"bash"* ]]; then
    RC_FILE="$HOME/.bashrc"
else
    RC_FILE="$HOME/.profile"
fi

echo "Open Control UI LVGL CLI Tools Installer"
echo "========================================="
echo ""
echo "Bin directory: $BIN_DIR"
echo "Shell config:  $RC_FILE"
echo ""

# Check if already in PATH
if echo "$PATH" | grep -q "$BIN_DIR"; then
    echo "Already in PATH. Nothing to do."
    exit 0
fi

# Check if already in config
if grep -q "ui-lvgl-cli-tools/bin" "$RC_FILE" 2>/dev/null; then
    echo "Already configured in $RC_FILE"
    echo "Run: source $RC_FILE"
    exit 0
fi

# Add to config
echo "" >> "$RC_FILE"
echo "# Open Control UI LVGL CLI Tools" >> "$RC_FILE"
echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$RC_FILE"

echo "Added to $RC_FILE"
echo ""
echo "To use now, run:"
echo "  source $RC_FILE"
echo ""
echo "Or open a new terminal."
echo ""
echo "Commands available:"
echo "  oc-icons  - Build icon fonts from SVG"
echo "  oc-font   - Convert TTF/OTF to LVGL binary (use convert_font.sh)"
echo "  oc-img    - Convert images to LVGL format (use convert_img.sh)"
echo ""
echo "Prerequisites:"
echo "  - Python 3"
echo "  - Inkscape (for SVG processing)"
echo "  - FontForge (for TTF generation)"
echo "  - Node.js + npm (for lv_font_conv)"
