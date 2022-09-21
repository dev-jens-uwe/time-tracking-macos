import AppKit

class Menu{
    private var statusItem: NSStatusItem!

    private var startTime : Date? = nil;
    
    init(){
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "play.fill", accessibilityDescription: "Time Tracking")
        }
                
        statusItem.menu = createMenu();
    }
    
    @objc
    private func toggleTimer(){
        let isTimerRunning = startTime != nil;
        
        if(isTimerRunning){
            startTime = nil
        }else{
            startTime = Date()
        }
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: isTimerRunning ? "play.fill" :"stop", accessibilityDescription: "Time Tracking")
        }
        
        statusItem.menu = createMenu()
    }
    
    private func createMenu() -> NSMenu {
        let menu = NSMenu()
        
        if(startTime == nil){
            let startTimer = NSMenuItem(title: "Start timer", action: #selector(toggleTimer), keyEquivalent: "1")
            startTimer.target = self;
            menu.addItem(startTimer)
        }else{
            let stopTimer = NSMenuItem(title: "Stop timer", action: #selector(toggleTimer), keyEquivalent: "1")
            stopTimer.target = self;
            menu.addItem(stopTimer)
        }
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        return menu
    }
}
