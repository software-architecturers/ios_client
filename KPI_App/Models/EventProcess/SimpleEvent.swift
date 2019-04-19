class SimpleEvent: Event {
    
    var simpleEventField : String
    
    private enum CodingKeys: String, CodingKey {
        case simpleEventField
    }
    
    required  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.simpleEventField = try container.decode(String.self, forKey: .simpleEventField)
        try super.init(from: decoder)
    }
    
    
}
