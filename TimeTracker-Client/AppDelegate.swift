import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var window: NSWindow!
    private var menu: Menu = Menu()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.miniaturizable, .closable, .resizable, .titled],
            backing: .buffered, defer: false)
        window.center()
        window.title = "Time tracking"
        // window.makeKeyAndOrderFront(nil)
    }
}
