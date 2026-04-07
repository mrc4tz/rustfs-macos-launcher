APP_NAME = RustFS
APP_DIR = build/$(APP_NAME).app
IDENTITY ?= -
SWIFT_FLAGS = -O -framework Cocoa -framework ServiceManagement

.PHONY: all clean build icons dmg sign notarize

all: build

# Build universal binary (arm64 + x86_64)
build: icons
	@echo "==> Compiling..."
	@mkdir -p "$(APP_DIR)/Contents/MacOS" "$(APP_DIR)/Contents/Resources"
	@swiftc $(SWIFT_FLAGS) -target arm64-apple-macosx13.0 -o /tmp/RustFS-arm64 RustFSMenuBar.swift
	@swiftc $(SWIFT_FLAGS) -target x86_64-apple-macosx13.0 -o /tmp/RustFS-x86_64 RustFSMenuBar.swift
	@lipo -create /tmp/RustFS-arm64 /tmp/RustFS-x86_64 -o "$(APP_DIR)/Contents/MacOS/RustFS"
	@rm -f /tmp/RustFS-arm64 /tmp/RustFS-x86_64
	@cp Info.plist "$(APP_DIR)/Contents/Info.plist"
	@cp build/AppIcon.icns "$(APP_DIR)/Contents/Resources/AppIcon.icns"
	@cp rustfs-helper.sh "$(APP_DIR)/Contents/Resources/rustfs-helper.sh"
	@chmod +x "$(APP_DIR)/Contents/Resources/rustfs-helper.sh"
	@echo "==> Build complete: $(APP_DIR)"

# Generate app icon
icons:
	@echo "==> Generating icons..."
	@swiftc -O -o /tmp/GenIcon GenerateRustFSIcon.swift -framework Cocoa && /tmp/GenIcon
	@iconutil -c icns /tmp/RustFS.iconset -o build/AppIcon.icns
	@rm -f /tmp/GenIcon

# Sign with Developer ID
sign:
	@echo "==> Signing with: $(IDENTITY)"
	codesign --force --deep --options runtime --timestamp -s "$(IDENTITY)" "$(APP_DIR)"

# Create DMG
dmg: build
	@bash create-dmg.sh

# Notarize (requires IDENTITY and keychain profile)
notarize:
	xcrun notarytool submit build/RustFS-Installer.dmg --keychain-profile "RustFS" --wait
	xcrun stapler staple build/RustFS-Installer.dmg

clean:
	@rm -rf build /tmp/RustFS.iconset /tmp/InstallerIcon.iconset
	@echo "Cleaned."
