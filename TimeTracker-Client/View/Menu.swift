import AppKit

class Menu{
    private var statusItem: NSStatusItem!

    private var startTime : Date? = nil;
    private var currentTimeItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
    
    init(){
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "", accessibilityDescription: "Time Tracking")
        }
                
        statusItem.menu = createMenu();
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTimeItem), userInfo: nil, repeats: true)
    }
    
    @objc
    private func toggleTimer(){
        let isTimerRunning = startTime != nil;
        
        if(isTimerRunning){
            EventBus.shared.pushEvent(event: ActionCreator.timerEnded())
            startTime = nil
        }else{
            EventBus.shared.pushEvent(event: ActionCreator.timerStarted())
            startTime = Date()
        }
        
        statusItem.menu = createMenu()
    }
    
    
    @objc private func updateCurrentTimeItem(){
        currentTimeItem.title = calculateTimeWorked()
        statusItem.button?.title = calculateTimeWorked()
    }
    
    private func createMenu() -> NSMenu {
        let menu = NSMenu()
        
        currentTimeItem = NSMenuItem(title: calculateTimeWorked(), action: nil, keyEquivalent: "")
        menu.addItem(currentTimeItem)
        
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
    
    
    private func calculateTimeWorked() -> String {
        let events = EventBus.shared.getEvents()
        
        var timeWorked = 0;
        var lastTimerStarted: TimerStartedEvent? = nil;
        
        events.forEach{
            let event = $0;
            if event is TimerStartedEvent{
                lastTimerStarted = event as? TimerStartedEvent;
            }
            
            if(event is TimerEndedEvent && lastTimerStarted != nil){
                let payload = event.payload as! TimerEndedPayload;
                
                timeWorked = timeWorked + Int(payload.time.timeIntervalSinceReferenceDate) - Int(lastTimerStarted!.payload.time.timeIntervalSinceReferenceDate)
                
                lastTimerStarted = nil;
            }
        }
        
        if(lastTimerStarted != nil){
            timeWorked = timeWorked + Int(Date().timeIntervalSinceReferenceDate) - Int(lastTimerStarted!.payload.time.timeIntervalSinceReferenceDate)
        }
        
        let hours = timeWorked / (60 * 60)
        let minutes = timeWorked % (60*60) / 60
        let seconds = timeWorked % 60
        
        return "\(hours):\(minutes):\(seconds)"
    }
}
