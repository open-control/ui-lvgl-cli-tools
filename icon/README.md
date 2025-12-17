# LVGL Icon Font Builder

Converts SVG icons to LVGL binary icon fonts with incremental builds.

## Pipeline

```
SVG files → Inkscape (clean) → FontForge (TTF) → lv_font_conv (LVGL binary)
```

## Usage

```bash
oc-icons
```

Run from any directory within a PlatformIO project.

## Configuration

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
UNITS_PER_EM="1000"
ASCENT="800"
DESCENT="200"
GLYPH_MARGIN="50"
UNICODE_START="0xE000"

# SVG processing
PADDING_PERCENT="0.10"

# LVGL settings
FONT_SIZES="S:12,M:14,L:16"
LVGL_BPP="4"

# C++ integration
HEADER_INCLUDE="Fonts.hpp"
FONTS_STRUCT="app_fonts"

# Tools (override for Windows)
# INKSCAPE="C:/Program Files/Inkscape/bin/inkscape.exe"
# FONTFORGE="C:/Program Files/FontForgeBuilds/bin/fontforge.exe"
```

## Output

### Icon.hpp

```cpp
// Auto-generated | 42 icons | 2024-01-15
#pragma once
#include "Fonts.hpp"

#include <lvgl.h>

namespace Icon {
enum class Size : uint8_t { S = 12, M = 14, L = 16 };

    constexpr const char* PLAY = "\xEE\x80\x80";
    constexpr const char* STOP = "\xEE\x80\x81";
    // ... more icons

inline void set(lv_obj_t* label, const char* icon, Size size = Size::M) {
    lv_font_t* font = (size == Size::S) ? app_fonts.icons_12
                        : (size == Size::M) ? app_fonts.icons_14
                        : app_fonts.icons_16;
    lv_obj_set_style_text_font(label, font, 0);
    lv_label_set_text(label, icon);
}
}  // namespace Icon
```

### Binary Data Files

```
src/ui/font/data/
├── app_icons_12.c.inc    # Binary data array
├── app_icons_12.hpp      # extern declarations
├── app_icons_14.c.inc
├── app_icons_14.hpp
├── app_icons_16.c.inc
└── app_icons_16.hpp
```

## Integration

### Fonts Struct

The generated `Icon::set()` expects a fonts struct. Define it in your `Fonts.hpp`:

```cpp
struct AppFonts {
    lv_font_t* icons_12 = nullptr;
    lv_font_t* icons_14 = nullptr;
    lv_font_t* icons_16 = nullptr;
    // ... text fonts
};

extern AppFonts app_fonts;
```

### Loading Fonts

```cpp
#include "data/app_icons_12.hpp"
#include "data/app_icons_14.hpp"
#include "data/app_icons_16.hpp"

void init_fonts() {
    app_fonts.icons_12 = lv_binfont_create_from_buffer(app_icons_12_bin, app_icons_12_bin_len);
    app_fonts.icons_14 = lv_binfont_create_from_buffer(app_icons_14_bin, app_icons_14_bin_len);
    app_fonts.icons_16 = lv_binfont_create_from_buffer(app_icons_16_bin, app_icons_16_bin_len);
}
```

### Using Icons

```cpp
#include "Icon.hpp"

lv_obj_t* label = lv_label_create(parent);
Icon::set(label, Icon::PLAY, Icon::Size::M);
```

## SVG Guidelines

- Use filled paths (no strokes)
- 24x24 or similar square viewBox recommended
- Keep it simple (no gradients, filters, masks)
- Name files descriptively: `play.svg`, `stop.svg`, `volume_up.svg`

Icons without a viewBox get auto-padded and centered.

## Incremental Builds

The builder tracks file hashes and only reprocesses changed SVGs:

```
● Processing SVGs (42 files)
  + new_icon.svg
  ~ modified_icon.svg
    unchanged_icon.svg
  ✓ SVGs: +1 ~1 =40

● Generating TTF
  ✓ app_icons.ttf (42 glyphs)
  ✓ Icon.hpp

● Generating LVGL fonts (12, 14, 16px)
  ✓ app_icons_12 (2048 bytes)
  ✓ app_icons_14 (2456 bytes)
  ✓ app_icons_16 (2864 bytes)

✓ Done!
```

## Requirements

- Python 3.9+
- Inkscape
- FontForge
- Node.js + npm
- lv_font_conv (`npm install -g lv_font_conv`)
