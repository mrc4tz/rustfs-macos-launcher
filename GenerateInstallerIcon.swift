import Cocoa

func generateIcon(size: Int) -> NSImage {
    let s = CGFloat(size)
    let img = NSImage(size: NSSize(width: s, height: s))
    img.lockFocus()

    let ctx = NSGraphicsContext.current!.cgContext
    let cs = CGColorSpaceCreateDeviceRGB()

    // Rounded rect background — green gradient
    let cornerRadius = s * 0.22
    let bgRect = CGRect(x: 0, y: 0, width: s, height: s)
    let bgPath = CGPath(roundedRect: bgRect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)

    ctx.saveGState()
    ctx.addPath(bgPath)
    ctx.clip()
    let bgC = [
        CGColor(red: 0.10, green: 0.55, blue: 0.35, alpha: 1.0),
        CGColor(red: 0.08, green: 0.42, blue: 0.30, alpha: 1.0),
        CGColor(red: 0.05, green: 0.30, blue: 0.22, alpha: 1.0)
    ] as CFArray
    if let g = CGGradient(colorsSpace: cs, colors: bgC, locations: [0.0, 0.5, 1.0]) {
        ctx.drawLinearGradient(g, start: CGPoint(x: 0, y: s), end: CGPoint(x: s, y: 0), options: [])
    }
    ctx.restoreGState()

    // Subtle glow
    ctx.saveGState()
    ctx.addPath(bgPath)
    ctx.clip()
    let glC = [
        CGColor(red: 0.3, green: 0.9, blue: 0.5, alpha: 0.12),
        CGColor(red: 0.3, green: 0.9, blue: 0.5, alpha: 0.0)
    ] as CFArray
    if let g = CGGradient(colorsSpace: cs, colors: glC, locations: [0.0, 1.0]) {
        ctx.drawRadialGradient(g, startCenter: CGPoint(x: s * 0.5, y: s * 0.65), startRadius: 0, endCenter: CGPoint(x: s * 0.5, y: s * 0.65), endRadius: s * 0.5, options: [])
    }
    ctx.restoreGState()

    // Down arrow (install/download symbol)
    let arrowColor = NSColor.white
    arrowColor.setStroke()
    arrowColor.setFill()

    let cx = s * 0.5
    let lineW = s * 0.06

    // Arrow shaft
    let shaft = NSBezierPath()
    shaft.move(to: NSPoint(x: cx, y: s * 0.72))
    shaft.line(to: NSPoint(x: cx, y: s * 0.32))
    shaft.lineWidth = lineW
    shaft.lineCapStyle = .round
    shaft.stroke()

    // Arrow head (V shape)
    let headPath = NSBezierPath()
    headPath.move(to: NSPoint(x: cx - s * 0.15, y: s * 0.44))
    headPath.line(to: NSPoint(x: cx, y: s * 0.28))
    headPath.line(to: NSPoint(x: cx + s * 0.15, y: s * 0.44))
    headPath.lineWidth = lineW
    headPath.lineCapStyle = .round
    headPath.lineJoinStyle = .round
    headPath.stroke()

    // Base line (tray/platform)
    let basePath = NSBezierPath()
    basePath.move(to: NSPoint(x: s * 0.25, y: s * 0.18))
    basePath.line(to: NSPoint(x: s * 0.75, y: s * 0.18))
    basePath.lineWidth = lineW
    basePath.lineCapStyle = .round
    basePath.stroke()

    img.unlockFocus()
    return img
}

let iconsetPath = "/tmp/InstallerIcon.iconset"
try? FileManager.default.createDirectory(atPath: iconsetPath, withIntermediateDirectories: true)

let sizes: [(String, Int)] = [
    ("icon_16x16", 16), ("icon_16x16@2x", 32),
    ("icon_32x32", 32), ("icon_32x32@2x", 64),
    ("icon_128x128", 128), ("icon_128x128@2x", 256),
    ("icon_256x256", 256), ("icon_256x256@2x", 512),
    ("icon_512x512", 512), ("icon_512x512@2x", 1024)
]

for (name, size) in sizes {
    let icon = generateIcon(size: size)
    let tiffData = icon.tiffRepresentation!
    let rep = NSBitmapImageRep(data: tiffData)!
    let pngData = rep.representation(using: .png, properties: [:])!
    try! pngData.write(to: URL(fileURLWithPath: "\(iconsetPath)/\(name).png"))
}
print("Installer iconset generated")
