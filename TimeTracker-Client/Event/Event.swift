protocol Event{
    associatedtype TPayload
    
    var type : String { get }
    
    var payload : TPayload { get }
}
