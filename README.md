# Open Control UI LVGL CLI Tools

Asset conversion tools for LVGL-based embedded UI projects.

## Prerequisites

- **Python 3**
- **Node.js** + npm (for `lv_font_conv`)
- **Inkscape** (for SVG processing)
- **FontForge** (for TTF generation)
- **Linux/macOS**: Bash shell
- **Windows**: [Git for Windows](https://git-scm.com/download/win) (provides Git Bash)

## Installation

### Linux / macOS

```bash
cd ui-lvgl-cli-tools
./install.sh
source ~/.bashrc  # or ~/.zshrc
```

### Windows (PowerShell)

```powershell
cd ui-lvgl-cli-tools
powershell -ExecutionPolicy Bypass -File install.ps1
# Restart terminal
```

### Manual

Add to your shell config (`~/.bashrc`, `~/.zshrc`, or `~/.profile`):

```bash
export PATH="$PATH:/path/to/open-control/ui-lvgl-cli-tools/bin"
```

## Commands

Run from any directory within a PlatformIO project:

| Command | Description |
|---------|-------------|
| `oc-icons` | Build icon font from SVG files (SVG → TTF → LVGL binary) |

### Font & Image Tools (Interactive)

These scripts are run directly from their directories:

| Script | Description |
|--------|-------------|
| `font/convert_font.sh` | Convert TTF/OTF to LVGL binary fonts |
| `img/convert_img.sh` | Convert images to LVGL C arrays |

## oc-icons

Builds LVGL icon fonts from SVG files with:
- Incremental builds (only processes changed files)
- SVG cleaning via Inkscape (strokes → paths, metadata removal)
- TTF generation via FontForge
- LVGL binary fonts at multiple sizes
- C++ header with icon constants and helper function

### Configuration

Create `script/lvgl/icon/icon_converter.conf` in your project:

```bash
# Paths relative to project root
SVG_SOURCE_DIR="asset/icon"
TTF_OUTPUT_DIR="asset/font"
HEADER_OUTPUT_DIR="src/ui/font"
CACHE_DIR=".cache/icons"

# Font settings
FONT_NAME="app_icons"
FONT_FAMILY="App Icons"
UNICODE_START="0xE000"

# LVGL settings
FONT_SIZES="S:12,M:14,L:16"
LVGL_BPP="4"

# C++ integration
HEADER_INCLUDE="Fonts.hpp"
FONTS_STRUCT="app_fonts"

# Tools (Linux defaults, override for Windows)
# INKSCAPE="C:/Program Files/Inkscape/bin/inkscape.exe"
# FONTFORGE="C:/Program Files/FontForgeBuilds/bin/fontforge.exe"
```

### Output Files

```
src/ui/font/
├── Icon.hpp           # Icon namespace with constexpr strings
└── data/
    ├── app_icons_12.c.inc
    ├── app_icons_12.hpp
    ├── app_icons_14.c.inc
    ├── app_icons_14.hpp
    ├── app_icons_16.c.inc
    └── app_icons_16.hpp
```

### Usage Example

```cpp
#include "Icon.hpp"

// Using the Icon namespace
lv_obj_t* label = lv_label_create(parent);
Icon::set(label, Icon::PLAY, Icon::Size::M);

// Or manually
lv_label_set_text(label, Icon::STOP);
```

## Font Converter

See [font/README.md](font/README.md) for TTF/OTF → LVGL binary conversion.

## Image Converter

See [img/README.md](img/README.md) for image → LVGL C array conversion.
