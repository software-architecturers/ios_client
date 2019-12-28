//
//  EventHelper.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/19/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class EventHelper {
    private var eventMap: [HashableType<Event>: EventViewController] = [:]
    
    
    func getEventViewController(by event : Event) -> EventViewController?{
        let eventType = type(of: event).hashable
        //let eventViewController = eventMap[eventType]
        let eventViewController = SimpleEventViewController()
        eventViewController.setEvent(event: event)
        return eventViewController
    }
    
    //add here types of eventViewControllers : SimpleEventViewController/ AdvEventViewController...
    init() {
        eventMap[SimpleEvent.hashable] = UIStoryboard.simpleEventViewController()
    }
    
    func getUserViewController(user : User) -> LoggedUserViewController?{
        let userViewController = LoggedUserViewController()
        userViewController.user = user
        return userViewController
    }
}
