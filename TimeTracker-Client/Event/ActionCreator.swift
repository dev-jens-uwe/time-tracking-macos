import Foundation

class ActionCreator{
    
    public static func timerStarted() -> TimerStartedEvent {
        return TimerStartedEvent(type:TIMER_STARTED, payload: TimerStartedPayload())
    }
    
    public static func timerEnded() -> TimerEndedEvent{
        return TimerEndedEvent(type: TIMER_ENDED, payload: TimerEndedPayload())
    }
}
