class EventBus{
    static let shared = EventBus()
    
    private var events: [any Event] = [];
    
    private init(){
        
    }
    
    public func pushEvent(event: any Event){
        self.events.append(event)
    }
    
    public func getEvents() -> [any Event]{
        return events;
    }
}
