import Cocoa

// Generate RustFS app icon: "R" letter with storage/drive concept
func generateIcon(size: Int) -> NSImage {
    let s = CGFloat(size)
    let img = NSImage(size: NSSize(width: s, height: s))
    img.lockFocus()

    let ctx = NSGraphicsContext.current!.cgContext

    // Background rounded rect
    let cornerRadius = s * 0.22
    let bgRect = CGRect(x: 0, y: 0, width: s, height: s)
    let bgPath = CGPath(roundedRect: bgRect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)

    // Gradient background - deep blue to teal
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let gradientColors = [
        CGColor(red: 0.08, green: 0.12, blue: 0.27, alpha: 1.0),
        CGColor(red: 0.05, green: 0.22, blue: 0.35, alpha: 1.0),
        CGColor(red: 0.02, green: 0.35, blue: 0.45, alpha: 1.0)
    ] as CFArray
    let locations: [CGFloat] = [0.0, 0.5, 1.0]

    ctx.saveGState()
    ctx.addPath(bgPath)
    ctx.clip()

    if let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: locations) {
        ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: s), end: CGPoint(x: s, y: 0), options: [])
    }
    ctx.restoreGState()

    // Subtle inner glow at top
    ctx.saveGState()
    ctx.addPath(bgPath)
    ctx.clip()
    let glowColors = [
        CGColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 0.15),
        CGColor(red: 0.3, green: 0.7, blue: 0.9, alpha: 0.0)
    ] as CFArray
    if let glow = CGGradient(colorsSpace: colorSpace, colors: glowColors, locations: [0.0, 1.0]) {
        ctx.drawRadialGradient(glow,
            startCenter: CGPoint(x: s * 0.5, y: s * 0.75),
            startRadius: 0,
            endCenter: CGPoint(x: s * 0.5, y: s * 0.75),
            endRadius: s * 0.6,
            options: [])
    }
    ctx.restoreGState()

    // Storage drive body
    let driveMargin = s * 0.15
    let driveW = s * 0.7
    let driveH = s * 0.22
    let driveY = s * 0.12
    let driveX = driveMargin
    let driveRadius = s * 0.04

    // Drive shadow
    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: -s * 0.01), blur: s * 0.03,
                  color: CGColor(red: 0, green: 0, blue: 0, alpha: 0.4))
    let drivePath = CGPath(roundedRect: CGRect(x: driveX, y: driveY, width: driveW, height: driveH),
                           cornerWidth: driveRadius, cornerHeight: driveRadius, transform: nil)
    ctx.addPath(drivePath)
    ctx.setFillColor(CGColor(red: 0.15, green: 0.45, blue: 0.6, alpha: 0.6))
    ctx.fillPath()
    ctx.restoreGState()

    // Drive border
    ctx.addPath(drivePath)
    ctx.setStrokeColor(CGColor(red: 0.4, green: 0.8, blue: 0.9, alpha: 0.7))
    ctx.setLineWidth(s * 0.012)
    ctx.strokePath()

    // Drive indicator lights (3 small circles)
    for i in 0..<3 {
        let dotX = driveX + s * 0.08 + CGFloat(i) * s * 0.07
        let dotY = driveY + driveH * 0.5
        let dotR = s * 0.018
        let dotRect = CGRect(x: dotX - dotR, y: dotY - dotR, width: dotR * 2, height: dotR * 2)
        ctx.addEllipse(in: dotRect)
        let dotColor = i == 0
            ? CGColor(red: 0.2, green: 0.9, blue: 0.5, alpha: 0.9)
            : CGColor(red: 0.4, green: 0.7, blue: 0.9, alpha: 0.5)
        ctx.setFillColor(dotColor)
        ctx.fillPath()
    }

    // Drive slot line
    let slotX = driveX + driveW * 0.55
    let slotW = driveW * 0.35
    let slotY2 = driveY + driveH * 0.5
    ctx.move(to: CGPoint(x: slotX, y: slotY2))
    ctx.addLine(to: CGPoint(x: slotX + slotW, y: slotY2))
    ctx.setStrokeColor(CGColor(red: 0.4, green: 0.7, blue: 0.85, alpha: 0.5))
    ctx.setLineWidth(s * 0.01)
    ctx.strokePath()

    // "R" letter - large, bold, centered above the drive
    let fontSize = s * 0.52
    let font = NSFont.systemFont(ofSize: fontSize, weight: .heavy)
    let rStr = "R" as NSString
    let shadow = NSShadow()
    shadow.shadowColor = NSColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
    shadow.shadowBlurRadius = s * 0.04
    shadow.shadowOffset = NSSize(width: 0, height: -s * 0.02)

    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: NSColor.white,
        .shadow: shadow
    ]
    let rSize = rStr.size(withAttributes: attrs)
    let rX = (s - rSize.width) / 2
    let rY = s * 0.28
    rStr.draw(at: NSPoint(x: rX, y: rY), withAttributes: attrs)

    // Subtle horizontal accent lines (data flow lines)
    for i in 0..<2 {
        let lineY = s * 0.40 + CGFloat(i) * s * 0.06
        let lineXStart = s * 0.72
        let lineXEnd = s * 0.88
        ctx.move(to: CGPoint(x: lineXStart, y: lineY))
        ctx.addLine(to: CGPoint(x: lineXEnd, y: lineY))
        ctx.setStrokeColor(CGColor(red: 0.3, green: 0.8, blue: 0.9, alpha: 0.3 + CGFloat(i) * 0.15))
        ctx.setLineWidth(s * 0.008)
        ctx.setLineCap(.round)
        ctx.strokePath()
    }

    img.unlockFocus()
    return img
}

// Generate all required sizes for .iconset
let iconsetPath = "/tmp/RustFS.iconset"
try? FileManager.default.createDirectory(atPath: iconsetPath, withIntermediateDirectories: true)

let sizes: [(String, Int)] = [
    ("icon_16x16", 16),
    ("icon_16x16@2x", 32),
    ("icon_32x32", 32),
    ("icon_32x32@2x", 64),
    ("icon_128x128", 128),
    ("icon_128x128@2x", 256),
    ("icon_256x256", 256),
    ("icon_256x256@2x", 512),
    ("icon_512x512", 512),
    ("icon_512x512@2x", 1024)
]

for (name, size) in sizes {
    let icon = generateIcon(size: size)
    let tiffData = icon.tiffRepresentation!
    let rep = NSBitmapImageRep(data: tiffData)!
    let pngData = rep.representation(using: .png, properties: [:])!
    let path = "\(iconsetPath)/\(name).png"
    try! pngData.write(to: URL(fileURLWithPath: path))
    print("Generated \(name).png (\(size)x\(size))")
}

print("Done! Iconset at: \(iconsetPath)")
