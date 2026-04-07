# RustFS macOS Launcher

A native macOS menu bar application for managing [RustFS](https://github.com/nicholasrust/rustfs) object storage server. Similar to how Laravel Herd or Sequel Ace sits in your menu bar — start, stop, and configure RustFS with a single click.

![Platform](https://img.shields.io/badge/platform-macOS%2013%2B-blue)
![Architecture](https://img.shields.io/badge/arch-Universal%20(arm64%20%2B%20x86__64)-green)
![Swift](https://img.shields.io/badge/Swift-6-orange)

## Features

- **Menu Bar App** — Lives in your toolbar, no Dock icon clutter
- **Start/Stop/Restart** server with one click
- **Port Configuration** — Customizable API port (default: 9000) and Console port (default: 9001)
- **Domain Alias** — Auto-configures `rustfs.local` and `api.rustfs.local` via `/etc/hosts` + Laravel Herd Nginx proxy
- **Credential Management** — Full CRUD for access key / secret key pairs, switch active credential
- **Data Folder** — Configurable storage directory with Browse picker
- **Launch at Login** — Auto-start on macOS boot (default: enabled)
- **Notifications** — macOS native notifications for start/stop/error events with detailed error messages
- **Universal Binary** — Runs natively on both Apple Silicon (M1/M2/M3/M4) and Intel Macs
- **Signed & Notarized** — Distributed with Developer ID signature and Apple notarization

## Screenshot

Menu bar showing server status, ports, domain, and active credential:

```
┌─────────────────────────────────┐
│ RustFS Object Storage           │
│─────────────────────────────────│
│ ● Server Aktif                  │
│   API :9000  |  Console :9001   │
│   rustfs.local → Console        │
│   Credential: default           │
│─────────────────────────────────│
│ Start/Stop Server          ⌘S   │
│ Restart Server             ⌘R   │
│─────────────────────────────────│
│ Buka Console (:9001)       ⌘O   │
│ Buka API (:9000)                │
│ Buka Console — rustfs.local     │
│ Buka API — api.rustfs.local     │
│─────────────────────────────────│
│ Lihat Log                  ⌘L   │
│ Buka Data Folder                │
│─────────────────────────────────│
│ Pengaturan...              ⌘,   │
│─────────────────────────────────│
│ Quit RustFS                ⌘Q   │
└─────────────────────────────────┘
```

## Installation

### From DMG (Recommended)

1. Download `RustFS-Installer.dmg` from [Releases](https://github.com/mrc4tz/rustfs-macos-launcher/releases)
2. Open the DMG and drag `RustFS.app` to `Applications`
3. First launch — open Terminal and run:
   ```bash
   sudo xattr -cr /Applications/RustFS.app && open /Applications/RustFS.app
   ```
4. The app will appear in your menu bar

### Build from Source

**Requirements:** macOS 13+, Xcode Command Line Tools

```bash
git clone https://github.com/mrc4tz/rustfs-macos-launcher.git
cd rustfs-macos-launcher
make build
```

The app will be built to `build/RustFS.app`. Copy it to `/Applications/`.

To create a DMG:
```bash
make dmg
```

To sign with your Developer ID:
```bash
make sign IDENTITY="Developer ID Application: Your Name (TEAMID)"
```

## Configuration

All settings are stored in `~/Library/Application Support/RustFS/config.json`:

```json
{
  "apiPort": 9000,
  "consolePort": 9001,
  "domain": "rustfs.local",
  "dataPath": "/Users/you/rustfs-files",
  "rustfsBin": "/Users/you/rustfs",
  "launchAtLogin": true,
  "credentials": [
    {
      "id": "uuid",
      "name": "default",
      "accessKey": "admin",
      "secretKey": "admin",
      "active": true
    }
  ]
}
```

## Domain Alias (Laravel Herd Integration)

When the server starts, the app automatically:

1. Adds `rustfs.local` and `api.rustfs.local` to `/etc/hosts`
2. Creates Nginx proxy configs in Herd's config directory
3. Reloads Nginx

This allows you to access:
- **`http://rustfs.local`** — Console UI
- **`http://api.rustfs.local`** — S3-compatible API

> Requires [Laravel Herd](https://herd.laravel.com/) to be installed for domain alias to work. Without Herd, use `localhost:9000` and `localhost:9001` directly.

## Prerequisites

- [RustFS](https://github.com/nicholasrust/rustfs) binary downloaded and placed at the configured path (default: `~/rustfs`)
- macOS 13 Ventura or later

## Project Structure

```
├── RustFSMenuBar.swift          # Main app source (menu bar, settings, server control)
├── Info.plist                   # App bundle configuration
├── rustfs-helper.sh             # Privileged helper for /etc/hosts and nginx
├── GenerateRustFSIcon.swift     # App icon generator (R + storage drive)
├── GenerateInstallerIcon.swift  # Installer icon generator
├── GenerateDMGBackground.swift  # DMG background image generator
├── create-dmg.sh                # DMG packaging script (sign + notarize)
├── Makefile                     # Build system
└── README.md
```

## License

MIT
