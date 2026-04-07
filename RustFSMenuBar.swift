import Cocoa
import ServiceManagement

// MARK: - Localization

class L {
    static var lang: String { ConfigManager.shared.config.language }

    private static let strings: [String: [String: String]] = [
        // Menu
        "menu.header":              ["en": "RustFS Object Storage",      "id": "RustFS Object Storage"],
        "menu.server.active":       ["en": "● Server Active",            "id": "● Server Aktif"],
        "menu.server.stopped":      ["en": "○ Server Stopped",           "id": "○ Server Mati"],
        "menu.start":               ["en": "Start Server",               "id": "Start Server"],
        "menu.stop":                ["en": "Stop Server",                "id": "Stop Server"],
        "menu.restart":             ["en": "Restart Server",             "id": "Restart Server"],
        "menu.openConsole":         ["en": "Open Console",               "id": "Buka Console"],
        "menu.openAPI":             ["en": "Open API",                   "id": "Buka API"],
        "menu.viewLog":             ["en": "View Log",                   "id": "Lihat Log"],
        "menu.openDataFolder":      ["en": "Open Data Folder",          "id": "Buka Data Folder"],
        "menu.settings":            ["en": "Settings...",                "id": "Pengaturan..."],
        "menu.quit":                ["en": "Quit RustFS",                "id": "Keluar RustFS"],

        // Settings window
        "settings.title":           ["en": "RustFS - Settings",          "id": "RustFS - Pengaturan"],
        "settings.tab.general":     ["en": "General",                    "id": "Umum"],
        "settings.tab.credentials": ["en": "Credentials",                "id": "Credentials"],
        "settings.save":            ["en": "Save",                       "id": "Simpan"],
        "settings.cancel":          ["en": "Cancel",                     "id": "Batal"],

        // General tab
        "general.portAPI":          ["en": "API Port:",                  "id": "Port API:"],
        "general.portConsole":      ["en": "Console Port:",              "id": "Port Console:"],
        "general.domain":           ["en": "Domain Alias:",              "id": "Domain Alias:"],
        "general.dataFolder":       ["en": "Data Folder:",               "id": "Data Folder:"],
        "general.binary":           ["en": "RustFS Binary:",             "id": "RustFS Binary:"],
        "general.language":         ["en": "Language:",                   "id": "Bahasa:"],
        "general.launchAtLogin":    ["en": "Launch at login",            "id": "Jalankan otomatis saat login"],
        "general.info":             ["en": "If the server is running, saving settings will automatically restart it. Domain alias requires administrator privileges to modify /etc/hosts.",
                                      "id": "Jika server sedang berjalan, perubahan pengaturan akan otomatis me-restart server. Domain alias memerlukan izin administrator untuk mengubah /etc/hosts."],
        "general.browse":           ["en": "Browse",                     "id": "Browse"],
        "general.pickFolder":       ["en": "Select Folder",              "id": "Pilih Folder"],
        "general.pickBinary":       ["en": "Select Binary",              "id": "Pilih Binary"],

        // Credentials tab
        "cred.active":              ["en": "Active",                     "id": "Aktif"],
        "cred.name":                ["en": "Name",                       "id": "Nama"],
        "cred.add":                 ["en": "Add",                        "id": "Tambah"],
        "cred.edit":                ["en": "Edit",                       "id": "Edit"],
        "cred.delete":              ["en": "Delete",                     "id": "Hapus"],
        "cred.setActive":           ["en": "Set Active",                 "id": "Set Aktif"],
        "cred.addTitle":            ["en": "Add Credential",             "id": "Tambah Credential"],
        "cred.editTitle":           ["en": "Edit Credential",            "id": "Edit Credential"],
        "cred.namePlaceholder":     ["en": "Credential name",            "id": "Nama credential"],
        "cred.nameLabel":           ["en": "Name:",                      "id": "Nama:"],
        "cred.selectEdit":          ["en": "Select a credential to edit",    "id": "Pilih credential yang ingin diedit"],
        "cred.selectDelete":        ["en": "Select a credential to delete",  "id": "Pilih credential yang ingin dihapus"],
        "cred.selectActive":        ["en": "Select a credential to activate","id": "Pilih credential yang ingin diaktifkan"],
        "cred.confirmDelete":       ["en": "Delete credential",          "id": "Hapus credential"],
        "cred.cannotUndo":          ["en": "This action cannot be undone.","id": "Tindakan ini tidak bisa dibatalkan."],
        "cred.allRequired":         ["en": "All fields are required",    "id": "Semua field harus diisi"],

        // Validation
        "val.portAPIInvalid":       ["en": "API Port is invalid (1-65535)",           "id": "Port API tidak valid (1-65535)"],
        "val.portConsoleInvalid":   ["en": "Console Port is invalid (1-65535)",       "id": "Port Console tidak valid (1-65535)"],
        "val.portsSame":            ["en": "API and Console ports cannot be the same","id": "Port API dan Console tidak boleh sama"],
        "val.dataEmpty":            ["en": "Data folder cannot be empty",             "id": "Data folder tidak boleh kosong"],
        "val.binEmpty":             ["en": "Binary path cannot be empty",             "id": "Path binary tidak boleh kosong"],

        // Notifications
        "notify.saved":             ["en": "Settings saved.",                          "id": "Pengaturan berhasil disimpan."],
        "notify.setupDone":         ["en": "Setup complete! Touch ID enabled for sudo.","id": "Setup selesai! Touch ID aktif untuk sudo."],
        "notify.alreadyRunning":    ["en": "RustFS is already running!",               "id": "RustFS sudah berjalan!"],
        "notify.binaryNotFound":    ["en": "RustFS binary not found:",                 "id": "Binary rustfs tidak ditemukan:"],
        "notify.serverStarted":     ["en": "Server started! Console:",                 "id": "Server aktif! Console:"],
        "notify.startFailed":       ["en": "Failed to start:",                         "id": "Gagal start:"],
        "notify.stopFailed":        ["en": "Failed to stop: server still running.",    "id": "Gagal stop: server masih berjalan."],
        "notify.serverStopped":     ["en": "Server stopped.",                          "id": "Server dihentikan."],
        "notify.noLog":             ["en": "No log available yet.",                    "id": "Belum ada log tersedia."],

        // Error extraction
        "err.portInUse":            ["en": "Port already in use. Check for other processes.", "id": "Port sudah digunakan. Cek apakah ada proses lain di port yang sama."],
        "err.noOutput":             ["en": "No output. Check binary and data folder paths.", "id": "Tidak ada output. Cek path binary dan data folder."],
        "err.unknown":              ["en": "Unknown error",                                   "id": "Error tidak diketahui"],
    ]

    static func s(_ key: String) -> String {
        return strings[key]?[lang] ?? strings[key]?["en"] ?? key
    }
}

// MARK: - Config Model

struct Credential: Codable {
    var id: String
    var name: String
    var accessKey: String
    var secretKey: String
    var active: Bool
}

struct AppConfig: Codable {
    var apiPort: Int
    var consolePort: Int
    var domain: String
    var dataPath: String
    var rustfsBin: String
    var launchAtLogin: Bool
    var language: String
    var credentials: [Credential]

    static func defaultConfig() -> AppConfig {
        return AppConfig(
            apiPort: 9000,
            consolePort: 9001,
            domain: "rustfs.local",
            dataPath: NSHomeDirectory() + "/rustfs-files",
            rustfsBin: NSHomeDirectory() + "/rustfs",
            launchAtLogin: true,
            language: "en",
            credentials: [
                Credential(id: UUID().uuidString, name: "default", accessKey: "admin", secretKey: "admin", active: true)
            ]
        )
    }
}

// MARK: - Config Manager

class ConfigManager {
    static let shared = ConfigManager()
    var config: AppConfig

    private var configDir: String {
        NSHomeDirectory() + "/Library/Application Support/RustFS"
    }
    private var configFile: String {
        configDir + "/config.json"
    }

    init() {
        config = AppConfig.defaultConfig()
        load()
    }

    func load() {
        guard FileManager.default.fileExists(atPath: configFile),
              let data = try? Data(contentsOf: URL(fileURLWithPath: configFile)),
              let loaded = try? JSONDecoder().decode(AppConfig.self, from: data) else { return }
        config = loaded
    }

    func save() {
        try? FileManager.default.createDirectory(atPath: configDir, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(config) {
            try? data.write(to: URL(fileURLWithPath: configFile))
        }
    }

    func activeCredential() -> Credential? {
        config.credentials.first(where: { $0.active })
    }

    func setActive(id: String) {
        for i in 0..<config.credentials.count {
            config.credentials[i].active = (config.credentials[i].id == id)
        }
        save()
    }

    func addCredential(_ cred: Credential) {
        var c = cred
        if config.credentials.isEmpty { c.active = true }
        config.credentials.append(c)
        save()
    }

    func deleteCredential(at index: Int) {
        let wasActive = config.credentials[index].active
        config.credentials.remove(at: index)
        if wasActive, !config.credentials.isEmpty {
            config.credentials[0].active = true
        }
        save()
    }

    func updateCredential(at index: Int, _ cred: Credential) {
        config.credentials[index] = cred
        save()
    }
}

// MARK: - Credential Editor Sheet

class CredentialEditorController: NSObject {
    var window: NSWindow!
    var nameField: NSTextField!
    var accessKeyField: NSTextField!
    var secretKeyField: NSTextField!
    var onSave: ((String, String, String) -> Void)?
    var parentWindow: NSWindow?

    func show(parent: NSWindow, name: String = "", accessKey: String = "", secretKey: String = "", title: String = "Tambah Credential", save: @escaping (String, String, String) -> Void) {
        onSave = save
        parentWindow = parent

        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 200),
                          styleMask: [.titled, .closable], backing: .buffered, defer: false)
        window.title = title
        window.isReleasedWhenClosed = false

        let content = window.contentView!

        let labels = [L.s("cred.nameLabel"), "Access Key:", "Secret Key:"]
        let yPositions = [150, 110, 70]

        for (i, label) in labels.enumerated() {
            let l = NSTextField(labelWithString: label)
            l.frame = NSRect(x: 20, y: yPositions[i], width: 100, height: 24)
            l.alignment = .right
            content.addSubview(l)
        }

        nameField = NSTextField(frame: NSRect(x: 130, y: 150, width: 245, height: 24))
        nameField.stringValue = name
        nameField.placeholderString = L.s("cred.namePlaceholder")
        content.addSubview(nameField)

        accessKeyField = NSTextField(frame: NSRect(x: 130, y: 110, width: 245, height: 24))
        accessKeyField.stringValue = accessKey
        accessKeyField.placeholderString = "Access key"
        content.addSubview(accessKeyField)

        secretKeyField = NSSecureTextField(frame: NSRect(x: 130, y: 70, width: 245, height: 24))
        secretKeyField.stringValue = secretKey
        secretKeyField.placeholderString = "Secret key"
        content.addSubview(secretKeyField)

        let cancelBtn = NSButton(title: L.s("settings.cancel"), target: self, action: #selector(cancel))
        cancelBtn.frame = NSRect(x: 210, y: 20, width: 80, height: 32)
        cancelBtn.bezelStyle = .rounded
        content.addSubview(cancelBtn)

        let saveBtn = NSButton(title: L.s("settings.save"), target: self, action: #selector(saveAction))
        saveBtn.frame = NSRect(x: 295, y: 20, width: 80, height: 32)
        saveBtn.bezelStyle = .rounded
        saveBtn.keyEquivalent = "\r"
        content.addSubview(saveBtn)

        parent.beginSheet(window)
    }

    @objc func cancel() {
        parentWindow?.endSheet(window)
        window.close()
    }

    @objc func saveAction() {
        let n = nameField.stringValue.trimmingCharacters(in: .whitespaces)
        let ak = accessKeyField.stringValue.trimmingCharacters(in: .whitespaces)
        let sk = secretKeyField.stringValue.trimmingCharacters(in: .whitespaces)
        guard !n.isEmpty, !ak.isEmpty, !sk.isEmpty else {
            let alert = NSAlert()
            alert.messageText = L.s("cred.allRequired")
            alert.runModal()
            return
        }
        parentWindow?.endSheet(window)
        window.close()
        onSave?(n, ak, sk)
    }
}

// MARK: - Settings Window Controller

class SettingsWindowController: NSObject, NSTableViewDelegate, NSTableViewDataSource {
    var window: NSWindow!
    var tabView: NSTabView!

    // General tab
    var apiPortField: NSTextField!
    var consolePortField: NSTextField!
    var domainField: NSTextField!
    var dataPathField: NSTextField!
    var binPathField: NSTextField!
    var launchAtLoginCheckbox: NSButton!
    var languagePopup: NSPopUpButton!

    // Credentials tab
    var tableView: NSTableView!
    var credEditor: CredentialEditorController?

    var onSettingsChanged: (() -> Void)?

    func show() {
        if let w = window, w.isVisible {
            w.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        buildWindow()
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func buildWindow() {
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 520, height: 420),
                          styleMask: [.titled, .closable], backing: .buffered, defer: false)
        window.title = L.s("settings.title")
        window.isReleasedWhenClosed = false

        tabView = NSTabView(frame: NSRect(x: 10, y: 50, width: 500, height: 360))

        let generalTab = NSTabViewItem(identifier: "general")
        generalTab.label = L.s("settings.tab.general")
        generalTab.view = buildGeneralTab()
        tabView.addTabViewItem(generalTab)

        let credTab = NSTabViewItem(identifier: "credentials")
        credTab.label = L.s("settings.tab.credentials")
        credTab.view = buildCredentialsTab()
        tabView.addTabViewItem(credTab)

        window.contentView!.addSubview(tabView)

        let saveBtn = NSButton(title: L.s("settings.save"), target: self, action: #selector(saveSettings))
        saveBtn.frame = NSRect(x: 420, y: 10, width: 90, height: 32)
        saveBtn.bezelStyle = .rounded
        saveBtn.keyEquivalent = "\r"
        window.contentView!.addSubview(saveBtn)

        let cancelBtn = NSButton(title: L.s("settings.cancel"), target: self, action: #selector(closeWindow))
        cancelBtn.frame = NSRect(x: 325, y: 10, width: 90, height: 32)
        cancelBtn.bezelStyle = .rounded
        cancelBtn.keyEquivalent = "\u{1b}"
        window.contentView!.addSubview(cancelBtn)
    }

    func buildGeneralTab() -> NSView {
        let view = NSView(frame: NSRect(x: 0, y: 0, width: 490, height: 310))
        let cfg = ConfigManager.shared.config

        let row1: CGFloat = 270  // Port API
        let row2: CGFloat = 236  // Port Console
        let row3: CGFloat = 202  // Domain Alias
        let row4: CGFloat = 168  // Data Folder
        let row5: CGFloat = 134  // RustFS Binary
        let row6: CGFloat = 100  // Language
        let row7: CGFloat = 72   // Launch at login

        let labelKeys = ["general.portAPI", "general.portConsole", "general.domain", "general.dataFolder", "general.binary", "general.language"]
        let yPos: [CGFloat] = [row1, row2, row3, row4, row5, row6]

        for (i, key) in labelKeys.enumerated() {
            let l = NSTextField(labelWithString: L.s(key))
            l.frame = NSRect(x: 15, y: yPos[i], width: 110, height: 22)
            l.alignment = .right
            view.addSubview(l)
        }

        apiPortField = NSTextField(frame: NSRect(x: 135, y: row1, width: 100, height: 24))
        apiPortField.stringValue = "\(cfg.apiPort)"
        apiPortField.placeholderString = "9000"
        view.addSubview(apiPortField)

        let apiHint = NSTextField(labelWithString: "Default: 9000")
        apiHint.frame = NSRect(x: 245, y: row1, width: 200, height: 22)
        apiHint.textColor = .secondaryLabelColor
        apiHint.font = NSFont.systemFont(ofSize: 11)
        view.addSubview(apiHint)

        consolePortField = NSTextField(frame: NSRect(x: 135, y: row2, width: 100, height: 24))
        consolePortField.stringValue = "\(cfg.consolePort)"
        consolePortField.placeholderString = "9001"
        view.addSubview(consolePortField)

        let consoleHint = NSTextField(labelWithString: "Default: 9001")
        consoleHint.frame = NSRect(x: 245, y: row2, width: 200, height: 22)
        consoleHint.textColor = .secondaryLabelColor
        consoleHint.font = NSFont.systemFont(ofSize: 11)
        view.addSubview(consoleHint)

        domainField = NSTextField(frame: NSRect(x: 135, y: row3, width: 330, height: 24))
        domainField.stringValue = cfg.domain
        domainField.placeholderString = "rustfs.local"
        view.addSubview(domainField)

        dataPathField = NSTextField(frame: NSRect(x: 135, y: row4, width: 280, height: 24))
        dataPathField.stringValue = cfg.dataPath
        dataPathField.placeholderString = NSHomeDirectory() + "/rustfs-files"
        view.addSubview(dataPathField)

        let browseDataBtn = NSButton(title: L.s("general.browse"), target: self, action: #selector(browseDataPath))
        browseDataBtn.frame = NSRect(x: 420, y: row4 - 2, width: 55, height: 28)
        browseDataBtn.bezelStyle = .rounded
        browseDataBtn.font = NSFont.systemFont(ofSize: 11)
        view.addSubview(browseDataBtn)

        binPathField = NSTextField(frame: NSRect(x: 135, y: row5, width: 280, height: 24))
        binPathField.stringValue = cfg.rustfsBin
        binPathField.placeholderString = NSHomeDirectory() + "/rustfs"
        view.addSubview(binPathField)

        let browseBinBtn = NSButton(title: L.s("general.browse"), target: self, action: #selector(browseBinPath))
        browseBinBtn.frame = NSRect(x: 420, y: row5 - 2, width: 55, height: 28)
        browseBinBtn.bezelStyle = .rounded
        browseBinBtn.font = NSFont.systemFont(ofSize: 11)
        view.addSubview(browseBinBtn)

        languagePopup = NSPopUpButton(frame: NSRect(x: 135, y: row6 - 2, width: 150, height: 26))
        languagePopup.addItems(withTitles: ["English", "Indonesia"])
        languagePopup.selectItem(withTitle: cfg.language == "id" ? "Indonesia" : "English")
        view.addSubview(languagePopup)

        launchAtLoginCheckbox = NSButton(checkboxWithTitle: L.s("general.launchAtLogin"), target: nil, action: nil)
        launchAtLoginCheckbox.frame = NSRect(x: 135, y: row7, width: 300, height: 20)
        launchAtLoginCheckbox.state = cfg.launchAtLogin ? .on : .off
        view.addSubview(launchAtLoginCheckbox)

        let separator = NSBox(frame: NSRect(x: 15, y: 55, width: 460, height: 1))
        separator.boxType = .separator
        view.addSubview(separator)

        let infoBox = NSTextField(wrappingLabelWithString: L.s("general.info"))
        infoBox.frame = NSRect(x: 15, y: 5, width: 460, height: 45)
        infoBox.textColor = .secondaryLabelColor
        infoBox.font = NSFont.systemFont(ofSize: 11)
        view.addSubview(infoBox)

        return view
    }

    func buildCredentialsTab() -> NSView {
        let view = NSView(frame: NSRect(x: 0, y: 0, width: 490, height: 310))

        let scrollView = NSScrollView(frame: NSRect(x: 15, y: 50, width: 460, height: 240))
        scrollView.hasVerticalScroller = true
        scrollView.borderType = .bezelBorder

        tableView = NSTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 28
        tableView.usesAlternatingRowBackgroundColors = true

        let colActive = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("active"))
        colActive.title = L.s("cred.active")
        colActive.width = 40
        tableView.addTableColumn(colActive)

        let colName = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("name"))
        colName.title = L.s("cred.name")
        colName.width = 120
        tableView.addTableColumn(colName)

        let colAK = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("accessKey"))
        colAK.title = "Access Key"
        colAK.width = 140
        tableView.addTableColumn(colAK)

        let colSK = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("secretKey"))
        colSK.title = "Secret Key"
        colSK.width = 130
        tableView.addTableColumn(colSK)

        scrollView.documentView = tableView
        view.addSubview(scrollView)

        let addBtn = NSButton(title: L.s("cred.add"), target: self, action: #selector(addCredential))
        addBtn.frame = NSRect(x: 15, y: 12, width: 80, height: 28)
        addBtn.bezelStyle = .rounded
        view.addSubview(addBtn)

        let editBtn = NSButton(title: L.s("cred.edit"), target: self, action: #selector(editCredential))
        editBtn.frame = NSRect(x: 100, y: 12, width: 70, height: 28)
        editBtn.bezelStyle = .rounded
        view.addSubview(editBtn)

        let delBtn = NSButton(title: L.s("cred.delete"), target: self, action: #selector(deleteCredential))
        delBtn.frame = NSRect(x: 175, y: 12, width: 70, height: 28)
        delBtn.bezelStyle = .rounded
        view.addSubview(delBtn)

        let activeBtn = NSButton(title: L.s("cred.setActive"), target: self, action: #selector(setActiveCredential))
        activeBtn.frame = NSRect(x: 250, y: 12, width: 80, height: 28)
        activeBtn.bezelStyle = .rounded
        view.addSubview(activeBtn)

        return view
    }

    // MARK: - Browse

    @objc func browseDataPath() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.prompt = L.s("general.pickFolder")
        if panel.runModal() == .OK, let url = panel.url {
            dataPathField.stringValue = url.path
        }
    }

    @objc func browseBinPath() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.prompt = L.s("general.pickBinary")
        if panel.runModal() == .OK, let url = panel.url {
            binPathField.stringValue = url.path
        }
    }

    // MARK: - Credential Actions

    @objc func addCredential() {
        credEditor = CredentialEditorController()
        credEditor?.show(parent: window, title: L.s("cred.addTitle")) { [weak self] name, ak, sk in
            let cred = Credential(id: UUID().uuidString, name: name, accessKey: ak, secretKey: sk, active: false)
            ConfigManager.shared.addCredential(cred)
            self?.tableView.reloadData()
        }
    }

    @objc func editCredential() {
        let row = tableView.selectedRow
        guard row >= 0 else {
            let a = NSAlert(); a.messageText = L.s("cred.selectEdit"); a.runModal()
            return
        }
        let cred = ConfigManager.shared.config.credentials[row]
        credEditor = CredentialEditorController()
        credEditor?.show(parent: window, name: cred.name, accessKey: cred.accessKey, secretKey: cred.secretKey, title: L.s("cred.editTitle")) { [weak self] name, ak, sk in
            var updated = cred
            updated.name = name; updated.accessKey = ak; updated.secretKey = sk
            ConfigManager.shared.updateCredential(at: row, updated)
            self?.tableView.reloadData()
        }
    }

    @objc func deleteCredential() {
        let row = tableView.selectedRow
        guard row >= 0 else {
            let a = NSAlert(); a.messageText = L.s("cred.selectDelete"); a.runModal()
            return
        }
        let cred = ConfigManager.shared.config.credentials[row]
        let alert = NSAlert()
        alert.messageText = "\(L.s("cred.confirmDelete")) \"\(cred.name)\"?"
        alert.informativeText = L.s("cred.cannotUndo")
        alert.addButton(withTitle: L.s("cred.delete"))
        alert.addButton(withTitle: L.s("settings.cancel"))
        alert.alertStyle = .warning
        if alert.runModal() == .alertFirstButtonReturn {
            ConfigManager.shared.deleteCredential(at: row)
            tableView.reloadData()
        }
    }

    @objc func setActiveCredential() {
        let row = tableView.selectedRow
        guard row >= 0 else {
            let a = NSAlert(); a.messageText = L.s("cred.selectActive"); a.runModal()
            return
        }
        let cred = ConfigManager.shared.config.credentials[row]
        ConfigManager.shared.setActive(id: cred.id)
        tableView.reloadData()
    }

    // MARK: - Save / Close

    @objc func saveSettings() {
        guard let api = Int(apiPortField.stringValue), api > 0, api <= 65535 else {
            let a = NSAlert(); a.messageText = L.s("val.portAPIInvalid"); a.runModal()
            return
        }
        guard let console = Int(consolePortField.stringValue), console > 0, console <= 65535 else {
            let a = NSAlert(); a.messageText = L.s("val.portConsoleInvalid"); a.runModal()
            return
        }
        guard api != console else {
            let a = NSAlert(); a.messageText = L.s("val.portsSame"); a.runModal()
            return
        }

        let dataPath = dataPathField.stringValue.trimmingCharacters(in: .whitespaces)
        let binPath = binPathField.stringValue.trimmingCharacters(in: .whitespaces)

        guard !dataPath.isEmpty else {
            let a = NSAlert(); a.messageText = L.s("val.dataEmpty"); a.runModal()
            return
        }
        guard !binPath.isEmpty else {
            let a = NSAlert(); a.messageText = L.s("val.binEmpty"); a.runModal()
            return
        }

        let cfg = ConfigManager.shared
        cfg.config.apiPort = api
        cfg.config.consolePort = console
        cfg.config.domain = domainField.stringValue.trimmingCharacters(in: .whitespaces)
        cfg.config.dataPath = dataPath
        cfg.config.rustfsBin = binPath
        cfg.config.launchAtLogin = launchAtLoginCheckbox.state == .on
        cfg.config.language = languagePopup.titleOfSelectedItem == "Indonesia" ? "id" : "en"
        cfg.save()

        // Apply launch at login
        LaunchAtLoginManager.set(enabled: cfg.config.launchAtLogin)

        window.close()
        onSettingsChanged?()
    }

    @objc func closeWindow() {
        window.close()
    }

    // MARK: - Table View

    func numberOfRows(in tableView: NSTableView) -> Int {
        return ConfigManager.shared.config.credentials.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cred = ConfigManager.shared.config.credentials[row]
        let id = tableColumn?.identifier.rawValue ?? ""

        let cell = NSTextField(labelWithString: "")
        cell.lineBreakMode = .byTruncatingTail

        switch id {
        case "active":
            cell.stringValue = cred.active ? "✓" : ""
            cell.alignment = .center
            if cred.active {
                cell.textColor = .systemGreen
                cell.font = NSFont.boldSystemFont(ofSize: 14)
            }
        case "name":
            cell.stringValue = cred.name
            if cred.active { cell.font = NSFont.boldSystemFont(ofSize: 13) }
        case "accessKey":
            cell.stringValue = cred.accessKey
            cell.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
        case "secretKey":
            cell.stringValue = String(repeating: "•", count: min(cred.secretKey.count, 16))
            cell.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
        default: break
        }
        return cell
    }
}

// MARK: - Hosts File Manager

// MARK: - Launch at Login

class LaunchAtLoginManager {
    static func set(enabled: Bool) {
        if #available(macOS 13.0, *) {
            do {
                if enabled {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
                NSLog("RustFS: launch at login = \(enabled)")
            } catch {
                NSLog("RustFS: failed to set launch at login: \(error)")
            }
        }
    }

    static var isEnabled: Bool {
        if #available(macOS 13.0, *) {
            return SMAppService.mainApp.status == .enabled
        }
        return false
    }
}

// MARK: - Hosts File Manager

class HostsManager {
    static let marker = "RustFS-managed"
    static let helperPath = "/usr/local/bin/rustfs-helper"
    static let nginxConfigDir = NSHomeDirectory() + "/Library/Application Support/Herd/config/valet/Nginx"

    // Check if helper is installed (setup done)
    static var isSetupDone: Bool {
        return FileManager.default.fileExists(atPath: helperPath)
            && FileManager.default.fileExists(atPath: "/etc/sudoers.d/rustfs")
    }

    // One-time setup: install helper + sudoers + Touch ID (needs single admin prompt)
    static func setup(completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .userInitiated).async {
            let bundledHelper = Bundle.main.resourcePath! + "/rustfs-helper.sh"
            let script = "do shell script \"/bin/bash '\(bundledHelper)' setup \(NSUserName())\" with administrator privileges"
            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
            task.arguments = ["-e", script]
            try? task.run()
            task.waitUntilExit()
            NSLog("RustFS: helper setup completed")
            DispatchQueue.main.async { completion?() }
        }
    }

    // Run helper command via sudo (no password needed after setup)
    private static func runHelper(_ args: [String], completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .userInitiated).async {
            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/bin/sudo")
            task.arguments = [helperPath] + args
            try? task.run()
            task.waitUntilExit()
            DispatchQueue.main.async { completion?() }
        }
    }

    static func addDomain(_ domain: String, completion: (() -> Void)? = nil) {
        guard !domain.isEmpty else { completion?(); return }
        let cfg = ConfigManager.shared.config

        // Write Herd Nginx configs (no admin needed, user-writable dir)
        let consoleNginx = """
        server {
            listen 127.0.0.1:80;
            server_name \(domain) www.\(domain);
            client_max_body_size 0;
            location / {
                proxy_pass http://127.0.0.1:\(cfg.consolePort);
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_buffering off;
                proxy_request_buffering off;
            }
            access_log off;
        }
        """

        let apiNginx = """
        server {
            listen 127.0.0.1:80;
            server_name api.\(domain);
            client_max_body_size 0;
            location / {
                proxy_pass http://127.0.0.1:\(cfg.apiPort);
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_buffering off;
                proxy_request_buffering off;
            }
            access_log off;
        }
        """

        try? consoleNginx.write(toFile: "\(nginxConfigDir)/\(domain)", atomically: true, encoding: .utf8)
        try? apiNginx.write(toFile: "\(nginxConfigDir)/api.\(domain)", atomically: true, encoding: .utf8)

        // Update hosts + reload nginx via helper (no password)
        runHelper(["hosts-add", domain, "\(cfg.consolePort)", "\(cfg.apiPort)"]) {
            NSLog("RustFS: domain \(domain) + api.\(domain) configured")
            completion?()
        }
    }

    static func removeDomain(completion: (() -> Void)? = nil) {
        let domain = ConfigManager.shared.config.domain

        // Remove nginx configs
        try? FileManager.default.removeItem(atPath: "\(nginxConfigDir)/\(domain)")
        try? FileManager.default.removeItem(atPath: "\(nginxConfigDir)/api.\(domain)")

        // Remove hosts + reload nginx via helper (no password)
        runHelper(["hosts-remove"]) {
            NSLog("RustFS: domain configs removed")
            completion?()
        }
    }
}

// MARK: - App Delegate

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var serverProcess: Process?
    var timer: Timer?
    var settingsController = SettingsWindowController()

    let pidFile = "/tmp/rustfs-server.pid"
    let logFile = "/tmp/rustfs-server.log"

    var cfg: AppConfig { ConfigManager.shared.config }

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        settingsController.onSettingsChanged = { [weak self] in
            guard let s = self else { return }
            s.buildMenu()
            s.notify(L.s("notify.saved"))
            if s.isRunning() {
                s.restartServer()
            }
        }

        updateIcon(running: false)
        buildMenu()

        // Auto-setup on first launch (single password prompt, then never again)
        if !HostsManager.isSetupDone {
            HostsManager.setup { [weak self] in
                self?.notify(L.s("notify.setupDone"))
                self?.buildMenu()
            }
        }

        // Apply launch at login setting
        LaunchAtLoginManager.set(enabled: cfg.launchAtLogin)

        if findExistingProcess() != nil {
            updateIcon(running: true)
            buildMenu()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.refreshStatus()
        }
    }

    // MARK: - Menu

    func buildMenu() {
        let menu = NSMenu()
        let running = isRunning()

        // Header
        let header = NSMenuItem(title: L.s("menu.header"), action: nil, keyEquivalent: "")
        header.isEnabled = false
        header.attributedTitle = NSAttributedString(string: L.s("menu.header"),
            attributes: [.font: NSFont.boldSystemFont(ofSize: 13)])
        menu.addItem(header)
        menu.addItem(NSMenuItem.separator())

        // Status
        let statusText = running ? L.s("menu.server.active") : L.s("menu.server.stopped")
        let si = NSMenuItem(title: statusText, action: nil, keyEquivalent: "")
        si.isEnabled = false
        si.attributedTitle = NSAttributedString(string: statusText,
            attributes: [
                .foregroundColor: running ? NSColor.systemGreen : NSColor.systemRed,
                .font: NSFont.systemFont(ofSize: 13)
            ])
        menu.addItem(si)

        // Port info
        let portInfo = NSMenuItem(title: "  API :\(cfg.apiPort)  |  Console :\(cfg.consolePort)", action: nil, keyEquivalent: "")
        portInfo.isEnabled = false
        portInfo.attributedTitle = NSAttributedString(string: "  API :\(cfg.apiPort)  |  Console :\(cfg.consolePort)",
            attributes: [.font: NSFont.monospacedSystemFont(ofSize: 11, weight: .regular), .foregroundColor: NSColor.secondaryLabelColor])
        menu.addItem(portInfo)

        if !cfg.domain.isEmpty {
            let domInfo = NSMenuItem(title: "  Domain: \(cfg.domain)", action: nil, keyEquivalent: "")
            domInfo.isEnabled = false
            let domText = running
                ? "  \(cfg.domain) → Console  |  api.\(cfg.domain) → API"
                : "  Domain: \(cfg.domain)"
            domInfo.attributedTitle = NSAttributedString(string: domText,
                attributes: [.font: NSFont.monospacedSystemFont(ofSize: 11, weight: .regular), .foregroundColor: NSColor.secondaryLabelColor])
            menu.addItem(domInfo)
        }

        if let cred = ConfigManager.shared.activeCredential() {
            let credInfo = NSMenuItem(title: "  Credential: \(cred.name)", action: nil, keyEquivalent: "")
            credInfo.isEnabled = false
            credInfo.attributedTitle = NSAttributedString(string: "  Credential: \(cred.name)",
                attributes: [.font: NSFont.systemFont(ofSize: 11), .foregroundColor: NSColor.secondaryLabelColor])
            menu.addItem(credInfo)
        }

        menu.addItem(NSMenuItem.separator())

        if running {
            let stop = NSMenuItem(title: L.s("menu.stop"), action: #selector(stopServer), keyEquivalent: "s")
            stop.target = self
            menu.addItem(stop)
        } else {
            let start = NSMenuItem(title: L.s("menu.start"), action: #selector(startServer), keyEquivalent: "s")
            start.target = self
            menu.addItem(start)
        }

        let restart = NSMenuItem(title: L.s("menu.restart"), action: #selector(restartServer), keyEquivalent: "r")
        restart.target = self
        restart.isEnabled = running
        menu.addItem(restart)

        menu.addItem(NSMenuItem.separator())

        let console = NSMenuItem(title: "\(L.s("menu.openConsole")) (:\(cfg.consolePort))", action: #selector(openConsolePort), keyEquivalent: "o")
        console.target = self
        console.isEnabled = running
        menu.addItem(console)

        let api = NSMenuItem(title: "\(L.s("menu.openAPI")) (:\(cfg.apiPort))", action: #selector(openAPIPort), keyEquivalent: "")
        api.target = self
        api.isEnabled = running
        menu.addItem(api)

        if !cfg.domain.isEmpty {
            let consoleAlias = NSMenuItem(title: "\(L.s("menu.openConsole")) — \(cfg.domain)", action: #selector(openConsoleAlias), keyEquivalent: "")
            consoleAlias.target = self
            consoleAlias.isEnabled = running
            menu.addItem(consoleAlias)

            let apiAlias = NSMenuItem(title: "\(L.s("menu.openAPI")) — api.\(cfg.domain)", action: #selector(openAPIAlias), keyEquivalent: "")
            apiAlias.target = self
            apiAlias.isEnabled = running
            menu.addItem(apiAlias)
        }

        menu.addItem(NSMenuItem.separator())

        let log = NSMenuItem(title: L.s("menu.viewLog"), action: #selector(openLogs), keyEquivalent: "l")
        log.target = self
        menu.addItem(log)

        let data = NSMenuItem(title: L.s("menu.openDataFolder"), action: #selector(openDataFolder), keyEquivalent: "")
        data.target = self
        menu.addItem(data)

        menu.addItem(NSMenuItem.separator())

        let settings = NSMenuItem(title: L.s("menu.settings"), action: #selector(openSettings), keyEquivalent: ",")
        settings.target = self
        menu.addItem(settings)

        menu.addItem(NSMenuItem.separator())

        let quit = NSMenuItem(title: L.s("menu.quit"), action: #selector(quitApp), keyEquivalent: "q")
        quit.target = self
        menu.addItem(quit)

        self.statusItem.menu = menu
    }

    // MARK: - Icon

    func makeMenuBarIcon(running: Bool) -> NSImage {
        let size = NSSize(width: 18, height: 18)
        let img = NSImage(size: size, flipped: false) { rect in
            NSColor.black.setFill()
            NSColor.black.setStroke()

            // Storage drive body
            let driveRect = CGRect(x: 1, y: 3, width: 16, height: 8)
            let drivePath = NSBezierPath(roundedRect: driveRect, xRadius: 2, yRadius: 2)
            drivePath.lineWidth = 1.2
            drivePath.stroke()

            // Drive indicator dot
            let dotRect = CGRect(x: 3.5, y: 5.5, width: 3, height: 3)
            let dotPath = NSBezierPath(ovalIn: dotRect)
            if running {
                dotPath.fill()
            } else {
                dotPath.lineWidth = 0.8
                dotPath.stroke()
            }

            // Drive slot line
            let slotPath = NSBezierPath()
            slotPath.move(to: NSPoint(x: 9, y: 7))
            slotPath.line(to: NSPoint(x: 15, y: 7))
            slotPath.lineWidth = 1.0
            slotPath.stroke()

            // "R" letter on top
            let font = NSFont.systemFont(ofSize: 8.5, weight: .bold)
            let attrs: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: NSColor.black
            ]
            let rStr = "R" as NSString
            let rSize = rStr.size(withAttributes: attrs)
            let rX = (rect.width - rSize.width) / 2
            rStr.draw(at: NSPoint(x: rX, y: 10), withAttributes: attrs)

            return true
        }
        img.isTemplate = true
        return img
    }

    func updateIcon(running: Bool) {
        guard let button = statusItem.button else { return }
        button.image = makeMenuBarIcon(running: running)
    }

    // MARK: - Server Control

    @objc func startServer() {
        if isRunning() {
            notify(L.s("notify.alreadyRunning"))
            return
        }

        // Validate binary
        guard FileManager.default.isExecutableFile(atPath: cfg.rustfsBin) else {
            notify("\(L.s("notify.binaryNotFound")) \(cfg.rustfsBin)")
            return
        }

        // Ensure data dir exists
        var isDir: ObjCBool = false
        if !FileManager.default.fileExists(atPath: cfg.dataPath, isDirectory: &isDir) || !isDir.boolValue {
            try? FileManager.default.createDirectory(atPath: cfg.dataPath, withIntermediateDirectories: true)
        }

        // Launch server first, then handle hosts + proxy async (non-blocking)
        launchServerProcess()

        // Add domains to /etc/hosts + configure Herd Nginx proxy
        if !cfg.domain.isEmpty {
            HostsManager.addDomain(cfg.domain)
        }
    }

    func launchServerProcess() {
        // Build the full shell command
        let bin = cfg.rustfsBin
        var args = "\"\(bin)\" server --console-enable --address :\(cfg.apiPort) --console-address :\(cfg.consolePort)"

        if !cfg.domain.isEmpty {
            args += " --server-domains \(cfg.domain)"
        }

        if let cred = ConfigManager.shared.activeCredential() {
            args += " --access-key \(cred.accessKey) --secret-key \(cred.secretKey)"
        }

        args += " \"\(cfg.dataPath)\""

        // Use /bin/sh -c to launch, which properly handles environment and process detachment
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", args]
        process.environment = ProcessInfo.processInfo.environment

        // Setup log file using pipe approach for reliability
        let outPipe = Pipe()
        process.standardOutput = outPipe
        process.standardError = outPipe

        // Write pipe output to log file in background
        let logPath = self.logFile
        DispatchQueue.global(qos: .background).async {
            // Clear old log
            FileManager.default.createFile(atPath: logPath, contents: nil)
            let fh = outPipe.fileHandleForReading
            while true {
                let data = fh.availableData
                if data.isEmpty { break }
                if let fileHandle = FileHandle(forWritingAtPath: logPath) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                }
            }
        }

        process.terminationHandler = { [weak self] _ in
            DispatchQueue.main.async {
                self?.serverProcess = nil
                self?.refreshStatus()
            }
        }

        do {
            try process.run()
            serverProcess = process
            try "\(process.processIdentifier)".write(toFile: pidFile, atomically: true, encoding: .utf8)

            NSLog("RustFS: launched with PID \(process.processIdentifier), cmd: \(args)")

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                guard let s = self else { return }
                s.refreshStatus()
                if s.isRunning() {
                    s.notify("\(L.s("notify.serverStarted")) http://localhost:\(s.cfg.consolePort)")
                } else {
                    let logContent = (try? String(contentsOfFile: logPath, encoding: .utf8)) ?? ""
                    // Extract meaningful error from log
                    let errorMsg = s.extractError(from: logContent)
                    NSLog("RustFS start failed. Log: \(logContent.suffix(500))")
                    s.notify("\(L.s("notify.startFailed")) \(errorMsg)")
                }
            }
        } catch {
            notify("\(L.s("notify.startFailed")) \(error.localizedDescription)")
            NSLog("RustFS Process.run() error: \(error)")
        }
    }

    @objc func stopServer() {
        // Kill our managed process (sh) and its children (rustfs)
        if let proc = serverProcess, proc.isRunning {
            // Kill the process group to ensure child rustfs process also dies
            let pgid = proc.processIdentifier
            kill(-pgid, SIGTERM)
            proc.terminate()
            serverProcess = nil
        }

        // Kill any existing rustfs process
        killAllRustfs()

        try? FileManager.default.removeItem(atPath: pidFile)

        // Remove domains from /etc/hosts + Herd Nginx configs
        if !cfg.domain.isEmpty {
            HostsManager.removeDomain()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let s = self else { return }
            s.refreshStatus()
            if s.isRunning() {
                s.notify(L.s("notify.stopFailed"))
            } else {
                s.notify(L.s("notify.serverStopped"))
            }
        }
    }

    @objc func restartServer() {
        if let proc = serverProcess, proc.isRunning {
            let pgid = proc.processIdentifier
            kill(-pgid, SIGTERM)
            proc.terminate()
            serverProcess = nil
        }
        killAllRustfs()
        try? FileManager.default.removeItem(atPath: pidFile)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.startServer()
        }
    }

    func killAllRustfs() {
        // pkill rustfs server processes
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/pkill")
        task.arguments = ["-f", "rustfs server"]
        try? task.run()
        task.waitUntilExit()
    }

    // MARK: - Actions

    @objc func openConsolePort() {
        NSWorkspace.shared.open(URL(string: "http://localhost:\(cfg.consolePort)")!)
    }

    @objc func openAPIPort() {
        NSWorkspace.shared.open(URL(string: "http://localhost:\(cfg.apiPort)")!)
    }

    @objc func openConsoleAlias() {
        NSWorkspace.shared.open(URL(string: "http://\(cfg.domain)")!)
    }

    @objc func openAPIAlias() {
        NSWorkspace.shared.open(URL(string: "http://api.\(cfg.domain)")!)
    }

    @objc func openLogs() {
        if FileManager.default.fileExists(atPath: logFile) {
            NSWorkspace.shared.open(URL(fileURLWithPath: logFile))
        } else {
            notify(L.s("notify.noLog"))
        }
    }

    @objc func openDataFolder() {
        NSWorkspace.shared.open(URL(fileURLWithPath: cfg.dataPath))
    }

    @objc func openSettings() {
        settingsController.show()
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }

    // MARK: - Process Helpers

    func isRunning() -> Bool {
        if let proc = serverProcess, proc.isRunning { return true }
        return findExistingProcess() != nil
    }

    func findExistingProcess() -> pid_t? {
        // Check PID file first
        if let pidStr = try? String(contentsOfFile: pidFile, encoding: .utf8),
           let pid = pid_t(pidStr.trimmingCharacters(in: .whitespacesAndNewlines)),
           pid > 0 {
            if kill(pid, 0) == 0 { return pid }
        }
        // Fallback: pgrep
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/pgrep")
        task.arguments = ["-f", "rustfs server"]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = FileHandle.nullDevice
        do {
            try task.run()
            task.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines),
               !output.isEmpty {
                // Filter out our own PID
                let myPid = ProcessInfo.processInfo.processIdentifier
                for line in output.components(separatedBy: "\n") {
                    if let pid = pid_t(line.trimmingCharacters(in: .whitespaces)), pid != myPid {
                        return pid
                    }
                }
            }
        } catch {}
        return nil
    }

    func refreshStatus() {
        let running = isRunning()
        updateIcon(running: running)
        buildMenu()
    }

    func notify(_ body: String) {
        // Sanitize for osascript (escape quotes and limit length)
        let safe = String(body.replacingOccurrences(of: "\"", with: "'")
                              .replacingOccurrences(of: "\\", with: "")
                              .prefix(200))
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
        task.arguments = ["-e", "display notification \"\(safe)\" with title \"RustFS\""]
        try? task.run()
    }

    func extractError(from logContent: String) -> String {
        // Try to find ERROR level message
        let lines = logContent.components(separatedBy: "\n").filter { !$0.isEmpty }
        for line in lines.reversed() {
            if line.contains("\"level\":\"ERROR\"") || line.contains("error") || line.contains("Error") {
                // Try to extract "message" field from JSON log
                if let msgRange = line.range(of: "\"message\":\""),
                   let endRange = line[msgRange.upperBound...].range(of: "\"") {
                    return String(line[msgRange.upperBound..<endRange.lowerBound])
                }
                // Try to extract "error" field
                if let errRange = line.range(of: "\"error\":\""),
                   let endRange = line[errRange.upperBound...].range(of: "\"") {
                    return String(line[errRange.upperBound..<endRange.lowerBound])
                }
                // Return trimmed line as fallback
                return String(line.prefix(150))
            }
        }
        // Check for common issues
        if logContent.contains("Address already in use") || logContent.contains("AddrInUse") {
            return L.s("err.portInUse")
        }
        if logContent.isEmpty {
            return L.s("err.noOutput")
        }
        // Return last line
        return String((lines.last ?? L.s("err.unknown")).prefix(150))
    }
}

// MARK: - Main

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
