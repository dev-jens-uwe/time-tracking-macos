import Foundation

let TIMER_ENDED = "TIMER_ENDED"

struct TimerEndedEvent: Event{
    typealias TPayload = TimerEndedPayload
    
    var type: String
    var payload: TimerEndedPayload
}

struct TimerEndedPayload {
    var time = Date()
}
