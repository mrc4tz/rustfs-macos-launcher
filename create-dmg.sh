#!/bin/bash
set -e

APP_NAME="RustFS"
DMG_FINAL="$HOME/Desktop/RustFS-Installer.dmg"
DMG_TEMP="/tmp/rustfs-rw.dmg"
STAGING="/tmp/rustfs-dmg-staging"
VOL_NAME="RustFS"

echo "==> Cleaning..."
rm -rf "$STAGING" "$DMG_TEMP" "$DMG_FINAL"
hdiutil detach "/Volumes/$VOL_NAME" 2>/dev/null || true

echo "==> Preparing staging..."
mkdir -p "$STAGING/.background"
cp -R "$HOME/Applications/${APP_NAME}.app" "$STAGING/"
ln -s /Applications "$STAGING/Applications"
cp /tmp/dmg-background.png "$STAGING/.background/background.png"

# Bundle rustfs binary in Resources (NOT MacOS — macOS validates all binaries there)
if [ -f "$HOME/rustfs" ]; then
    cp "$HOME/rustfs" "$STAGING/${APP_NAME}.app/Contents/Resources/rustfs-bin"
fi

IDENTITY="Developer ID Application: Mahryan Rakhmatullah (Q5Q5KKYWU7)"

# Sign rustfs-bin separately first (third-party binary needs its own signature)
if [ -f "$STAGING/${APP_NAME}.app/Contents/Resources/rustfs-bin" ]; then
    codesign --force --options runtime --timestamp \
        -s "$IDENTITY" \
        "$STAGING/${APP_NAME}.app/Contents/Resources/rustfs-bin"
fi

# Sign the whole app bundle
codesign --force --deep --options runtime --timestamp \
    -s "$IDENTITY" \
    "$STAGING/${APP_NAME}.app"

xattr -cr "$STAGING/${APP_NAME}.app"

echo "==> Creating writable DMG..."
hdiutil create -srcfolder "$STAGING" -volname "$VOL_NAME" -fs HFS+ \
    -format UDRW -size 250m "$DMG_TEMP"

echo "==> Mounting DMG..."
hdiutil attach "$DMG_TEMP" -mountpoint "/Volumes/$VOL_NAME" -noautoopen

echo "==> Styling DMG layout..."
osascript <<APPLESCRIPT
tell application "Finder"
    tell disk "$VOL_NAME"
        open
        delay 1

        set current view of container window to icon view
        set toolbar visible of container window to false
        set statusbar visible of container window to false

        set the bounds of container window to {200, 100, 860, 550}

        set viewOptions to the icon view options of container window
        set arrangement of viewOptions to not arranged
        set icon size of viewOptions to 90
        set text size of viewOptions to 12
        set background picture of viewOptions to file ".background:background.png"

        set position of item "${APP_NAME}.app" of container window to {180, 200}
        set position of item "Applications" of container window to {480, 200}

        close
        open
        delay 1
        close
    end tell
end tell
APPLESCRIPT

SetFile -a V "/Volumes/$VOL_NAME/.background" 2>/dev/null || true

echo "==> Finalizing..."
sync
hdiutil detach "/Volumes/$VOL_NAME"

echo "==> Compressing..."
hdiutil convert "$DMG_TEMP" -format UDZO -imagekey zlib-level=9 -o "$DMG_FINAL"

echo "==> Cleanup..."
rm -rf "$STAGING" "$DMG_TEMP"

SIZE=$(du -h "$DMG_FINAL" | cut -f1)
echo ""
echo "============================================"
echo "  DMG: $DMG_FINAL"
echo "  Size: $SIZE"
echo "============================================"
