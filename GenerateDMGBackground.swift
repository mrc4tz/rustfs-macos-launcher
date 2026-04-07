import Cocoa

func generateBackground() {
    let width: CGFloat = 660
    let height: CGFloat = 450
    let img = NSImage(size: NSSize(width: width, height: height))
    img.lockFocus()

    let ctx = NSGraphicsContext.current!.cgContext
    let cs = CGColorSpaceCreateDeviceRGB()

    // Dark gradient background
    let bgC = [
        CGColor(red: 0.06, green: 0.08, blue: 0.18, alpha: 1.0),
        CGColor(red: 0.04, green: 0.14, blue: 0.24, alpha: 1.0),
        CGColor(red: 0.03, green: 0.20, blue: 0.30, alpha: 1.0)
    ] as CFArray
    if let g = CGGradient(colorsSpace: cs, colors: bgC, locations: [0.0, 0.5, 1.0]) {
        ctx.drawLinearGradient(g, start: CGPoint(x: 0, y: height), end: CGPoint(x: width, y: 0), options: [])
    }

    // Subtle grid
    ctx.setStrokeColor(CGColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.04))
    ctx.setLineWidth(0.5)
    var x: CGFloat = 0
    while x <= width { ctx.move(to: CGPoint(x: x, y: 0)); ctx.addLine(to: CGPoint(x: x, y: height)); ctx.strokePath(); x += 30 }
    var y: CGFloat = 0
    while y <= height { ctx.move(to: CGPoint(x: 0, y: y)); ctx.addLine(to: CGPoint(x: width, y: y)); ctx.strokePath(); y += 30 }

    // Glow left
    let gl1 = [CGColor(red: 0.1, green: 0.5, blue: 0.7, alpha: 0.12), CGColor(red: 0.1, green: 0.5, blue: 0.7, alpha: 0.0)] as CFArray
    if let g = CGGradient(colorsSpace: cs, colors: gl1, locations: [0.0, 1.0]) {
        ctx.drawRadialGradient(g, startCenter: CGPoint(x: 180, y: 210), startRadius: 0, endCenter: CGPoint(x: 180, y: 210), endRadius: 120, options: [])
    }
    // Glow right
    let gl2 = [CGColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 0.08), CGColor(red: 0.2, green: 0.6, blue: 0.8, alpha: 0.0)] as CFArray
    if let g = CGGradient(colorsSpace: cs, colors: gl2, locations: [0.0, 1.0]) {
        ctx.drawRadialGradient(g, startCenter: CGPoint(x: 480, y: 210), startRadius: 0, endCenter: CGPoint(x: 480, y: 210), endRadius: 120, options: [])
    }

    // Arrow
    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: 0), blur: 15, color: CGColor(red: 0.3, green: 0.8, blue: 1.0, alpha: 0.4))
    NSColor(red: 0.4, green: 0.85, blue: 0.95, alpha: 0.8).setStroke()

    let shaft = NSBezierPath()
    shaft.move(to: NSPoint(x: 255, y: 200)); shaft.line(to: NSPoint(x: 385, y: 200))
    shaft.lineWidth = 2.5; shaft.lineCapStyle = .round; shaft.stroke()

    let head = NSBezierPath()
    head.move(to: NSPoint(x: 370, y: 215)); head.line(to: NSPoint(x: 395, y: 200)); head.line(to: NSPoint(x: 370, y: 185))
    head.lineWidth = 2.5; head.lineCapStyle = .round; head.lineJoinStyle = .round; head.stroke()
    ctx.restoreGState()

    // Dots
    for i in 0..<3 {
        let dx = 285 + CGFloat(i) * 40
        let a = 0.3 + CGFloat(i) * 0.25
        NSColor(red: 0.4, green: 0.85, blue: 0.95, alpha: a).setFill()
        NSBezierPath(ovalIn: CGRect(x: dx - 2.5, y: 197.5, width: 5, height: 5)).fill()
    }

    // Title
    let titleAttrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 28, weight: .bold), .foregroundColor: NSColor.white]
    let title = "RustFS" as NSString
    let ts = title.size(withAttributes: titleAttrs)
    title.draw(at: NSPoint(x: (width - ts.width) / 2, y: height - 60), withAttributes: titleAttrs)

    // Subtitle
    let subAttrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 13), .foregroundColor: NSColor(red: 0.6, green: 0.8, blue: 0.9, alpha: 0.8)]
    let sub = "Drag to Applications to install" as NSString
    let ss = sub.size(withAttributes: subAttrs)
    sub.draw(at: NSPoint(x: (width - ss.width) / 2, y: height - 85), withAttributes: subAttrs)

    // Icon labels
    let lAttrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 12, weight: .medium), .foregroundColor: NSColor(red: 0.7, green: 0.85, blue: 0.95, alpha: 0.9)]
    let l1 = "RustFS" as NSString; let l1s = l1.size(withAttributes: lAttrs)
    l1.draw(at: NSPoint(x: 180 - l1s.width / 2, y: 105), withAttributes: lAttrs)
    let l2 = "Applications" as NSString; let l2s = l2.size(withAttributes: lAttrs)
    l2.draw(at: NSPoint(x: 480 - l2s.width / 2, y: 105), withAttributes: lAttrs)

    // ── First launch hint box ──
    let boxRect = CGRect(x: 30, y: 15, width: width - 60, height: 80)
    let boxPath = NSBezierPath(roundedRect: boxRect, xRadius: 10, yRadius: 10)
    NSColor(red: 0.08, green: 0.15, blue: 0.25, alpha: 0.6).setFill()
    boxPath.fill()
    NSColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 0.15).setStroke()
    boxPath.lineWidth = 0.5; boxPath.stroke()

    let hintTitleAttrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 11.5, weight: .semibold),
        .foregroundColor: NSColor(red: 0.85, green: 0.9, blue: 0.95, alpha: 0.9)
    ]
    let hintTitle = "Pertama kali buka? Jalankan di Terminal:" as NSString
    hintTitle.draw(at: NSPoint(x: 50, y: 68), withAttributes: hintTitleAttrs)

    let cmdAttrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.monospacedSystemFont(ofSize: 11.5, weight: .medium),
        .foregroundColor: NSColor(red: 0.4, green: 0.85, blue: 0.95, alpha: 0.95)
    ]
    let cmd = "sudo xattr -cr /Applications/RustFS.app && open /Applications/RustFS.app" as NSString
    cmd.draw(at: NSPoint(x: 50, y: 40), withAttributes: cmdAttrs)

    // Version
    let vAttrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 9, weight: .light), .foregroundColor: NSColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 0.4)]
    let v = "Object Storage Server  •  v1.1" as NSString; let vs = v.size(withAttributes: vAttrs)
    v.draw(at: NSPoint(x: (width - vs.width) / 2, y: 22), withAttributes: vAttrs)

    img.unlockFocus()

    let tiffData = img.tiffRepresentation!
    let rep = NSBitmapImageRep(data: tiffData)!
    let pngData = rep.representation(using: .png, properties: [:])!
    try! pngData.write(to: URL(fileURLWithPath: "/tmp/dmg-background.png"))
    print("Background generated")
}

generateBackground()
