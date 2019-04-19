//
//  EventsService.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 3/30/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

struct ImageIdEvent{
    var id: Int?
    var image: UIImage?
    
    init(id: Int, image: UIImage) {
        self.id = id
        self.image = image
    }
}

struct Events: Decodable {
    let events: [Event]
    
    enum EventsKey: CodingKey {
        case events
    }
    
    enum EventTypeKey: CodingKey {
        case type
    }
    
    enum EventTypes: String, Decodable {
        case simple = "simpleEvent"
        case advertisement = "advEvent"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EventsKey.self)
        var eventsArrayForType = try container.nestedUnkeyedContainer(forKey: EventsKey.events)
        var events = [Event]()
        
        var eventsArray = eventsArrayForType
        while(!eventsArrayForType.isAtEnd)
        {
            let event = try eventsArrayForType.nestedContainer(keyedBy: EventTypeKey.self)
            let type = try event.decode(EventTypes.self, forKey: EventTypeKey.type)
            switch type {
            case .advertisement:
                print("found event")
                events.append(try eventsArray.decode(Event.self))
            case .simple:
                print("found simpleEvent")
                events.append(try eventsArray.decode(SimpleEvent.self))
            }
        }
        self.events = events
    }
}


class EventsService {
    
    
}
