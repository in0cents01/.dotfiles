# macOS-style

A one-click setup for turning a standard Ubuntu GNOME desktop into a cleaner, more macOS-like workspace using WhiteSur themes, GNOME extensions, and panel tweaks.

This script installs the theme, enables the required extensions, applies the macOS-inspired layout, and configures the panel for a slim, polished look.

## Requirements

- Ubuntu 
- GNOME desktop environment
- An account with `sudo` access

## Quick start

Save the script as `macos-topbar.sh` and run it:

```bash
bash macos-topbar.sh
```

Use `bash`, not `zsh`, to avoid shell globbing issues in the installer flow.

When the script is finished, log out and log back in to apply the new shell extensions and desktop theme.

## What the script does

- Installs required system packages
- Installs the WhiteSur GTK theme, icons, and cursors
- Installs and enables the necessary GNOME extensions
- Configures the top bar to remove clutter and mimic the macOS panel layout
- Applies a dark mode desktop theme and polished dock styling

## Script

```bash
#!/usr/bin/env bash
# macOS-style top bar for Ubuntu GNOME
export PATH="$PATH:$HOME/.local/bin"
EXT="$HOME/.local/share/gnome-shell/extensions"

echo "==> [1/6] Installing packages"
sudo apt update
sudo apt install -y git sassc libglib2.0-dev-bin gnome-tweaks \
  gnome-shell-extensions gnome-shell-extension-manager pipx fonts-inter

echo "==> [2/6] Installing gnome-extensions-cli (gext)"
pipx install gnome-extensions-cli --system-site-packages 2>/dev/null || true
pipx ensurepath >/dev/null 2>&1 || true

echo "==> [3/6] Installing WhiteSur theme, icons, cursors"
cd /tmp || exit 1
rm -rf WhiteSur-gtk-theme WhiteSur-icon-theme WhiteSur-cursors
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors.git
(cd WhiteSur-gtk-theme  && ./install.sh -c Dark -l --shell -i apple -N glassy)
(cd WhiteSur-icon-theme && ./install.sh -b)
(cd WhiteSur-cursors    && ./install.sh)

echo "==> [4/6] Installing GNOME extensions"
EXTS="user-theme@gnome-shell-extensions.gcampax.github.com
just-perfection-desktop@just-perfection
blur-my-shell@aunetx
logomenu@aryan_k
unite@hardpixel.eu
rounded-window-corners@fxgn"

for x in $EXTS; do
  if [ ! -d "$EXT/$x" ] && [ "$x" != "user-theme@gnome-shell-extensions.gcampax.github.com" ]; then
    gext install "$x" || echo "   (skipped $x - not available for your GNOME version)"
  fi
  [ -d "$EXT/$x/schemas" ] && glib-compile-schemas "$EXT/$x/schemas"
done

# Enable extensions (works even before the first re-login)
python3 - <<'PY'
import subprocess, ast
want = """user-theme@gnome-shell-extensions.gcampax.github.com
just-perfection-desktop@just-perfection
blur-my-shell@aunetx
logomenu@aryan_k
unite@hardpixel.eu
rounded-window-corners@fxgn""".split()
cur = subprocess.run(["gsettings","get","org.gnome.shell","enabled-extensions"],
                     capture_output=True, text=True).stdout.strip()
try:
    lst = ast.literal_eval(cur.replace("@as ", ""))
except Exception:
    lst = []
for w in want:
    if w not in lst:
        lst.append(w)
subprocess.run(["gsettings","set","org.gnome.shell","enabled-extensions",str(lst)])
PY

echo "==> [5/6] Applying extension settings"
# helper: set <extension-uuid> <schema> <key> <value>
s() {
  local d="$EXT/$1/schemas"; shift
  if [ -d "$d" ]; then
    gsettings --schemadir "$d" set "$@" 2>/dev/null || echo "   (could not set: $*)"
  fi
}

JP=just-perfection-desktop@just-perfection
BM=blur-my-shell@aunetx
UN=unite@hardpixel.eu
JPS=org.gnome.shell.extensions.just-perfection
BMS=org.gnome.shell.extensions.blur-my-shell.panel
UNS=org.gnome.shell.extensions.unite

# Just Perfection: slim bar, no Activities, no clutter
s $JP $JPS activities-button false
s $JP $JPS panel-size 28
s $JP $JPS clock-menu-position 0
s $JP $JPS accessibility-menu false
s $JP $JPS keyboard-layout false
s $JP $JPS workspace-switcher-should-show false

# Blur my Shell: blurred translucent bar
s $BM $BMS blur true
s $BM $BMS customize true
s $BM $BMS sigma 20
s $BM $BMS brightness 0.9

# Unite: show the active app name in the top bar
s $UN $UNS show-appmenu-button true
s $UN $UNS hide-activities-button always
s $UN $UNS show-window-title never
s $UN $UNS window-buttons-placement none

echo "==> [6/6] Applying theme, icons, fonts, dock"
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark' 2>/dev/null || true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' 2>/dev/null || true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DYNAMIC' 2>/dev/null || true

echo
echo "DONE. Now LOG OUT and LOG BACK IN."
echo "Then open Extension Manager, check all extensions are ON,"
echo "and in Logo Menu settings choose the Apple icon."
```

## Post-install steps

After logging back in:

1. Open **Extension Manager** and confirm the following are enabled:
   - User Themes
   - Just Perfection
   - Blur my Shell
   - Logo Menu
   - Unite
   - Rounded Window Corners Reborn
2. Open **Logo Menu settings** and choose the Apple-style icon.
3. Optionally install **Panel Date Format** and set it to `%a %b %e  %l:%M %p` for a cleaner clock.

## Resulting layout

- Far left: logo button and active app name
- Center: clock
- Right: Wi‑Fi, volume, and battery indicators
- Slim, translucent top bar with a macOS-like dock and WhiteSur styling

## Notes and troubleshooting

- The script skips extensions that are not supported by your GNOME version and continues with the rest.
- Full app menus such as File / Edit / View require compatibility extensions and are only partially supported.
- To switch to a light theme, replace `Dark` with `Light`, `WhiteSur-Dark` with `WhiteSur-Light`, and `WhiteSur-dark` with `WhiteSur-light`.
- To undo the changes, run:

```bash
gsettings reset-recursively org.gnome.desktop.interface
```

Then disable the extensions in **Extension Manager**.
