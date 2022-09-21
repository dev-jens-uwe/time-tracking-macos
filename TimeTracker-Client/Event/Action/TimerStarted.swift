import Foundation

let TIMER_STARTED = "TIMER_STARTED"

struct TimerStartedEvent: Event{
    typealias TPayload = TimerStartedPayload
    
    var type: String
    var payload: TimerStartedPayload
}

struct TimerStartedPayload {
    var time = Date()
}
