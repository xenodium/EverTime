import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  let window: NSWindow = .makeWindow()
  var hostingView: NSView = NSHostingView(rootView: ClockView())

  func applicationDidFinishLaunching(_ notification: Notification) {
    NSApp.delegate = self
    NSApp.mainMenu = NSMenu.makeMenu()
    window.contentView = hostingView
  }
}

extension NSWindow {
  static func makeWindow() -> NSWindow {
    let window = NSWindow(
      contentRect: NSRect.makeDefault(),
      styleMask: [
        .closable,
        .miniaturizable,
        .resizable,
        .fullSizeContentView,
      ],
      backing: .buffered, defer: false)
    window.level = .floating
    window.setFrameAutosaveName("EverTime")
    window.collectionBehavior = [
      .canJoinAllSpaces,
      .stationary,
      .ignoresCycle,
      .fullScreenPrimary,
    ]
    window.makeKeyAndOrderFront(nil)
    window.isMovableByWindowBackground = true
    window.titleVisibility = .hidden
    window.backgroundColor = .clear
    return window
  }
}

extension NSRect {
  static func makeDefault() -> NSRect {
    let initialMargin = CGFloat(60)
    let fallback = NSRect(x: 0, y: 0, width: 210, height: 110)

    guard let screenFrame = NSScreen.main?.frame else {
      return fallback
    }

    return NSRect(
      x: screenFrame.maxX - fallback.width - initialMargin,
      y: screenFrame.maxY - fallback.height - initialMargin,
      width: fallback.width, height: fallback.height)
  }
}

extension NSMenu {
  static func makeMenu() -> NSMenu {
    let appMenu = NSMenuItem()
    appMenu.submenu = NSMenu()

    appMenu.submenu?.addItem(
      NSMenuItem(
        title: "Quit \(ProcessInfo.processInfo.processName)",
        action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"
      ))

    let mainMenu = NSMenu(title: "Main Menu")
    mainMenu.addItem(appMenu)
    return mainMenu
  }
}
