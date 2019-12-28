//
//  NonBackEvent.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/19/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import CoreLocation


let userGlobalURL = URL(string: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/peaky-blinders-19-1565294142.jpg?crop=0.667xw:1.00xh;0.282xw,0&resize=480:*")!
let imageGlobalURL = URL(string: "https://thumbs-prod.si-cdn.com/h4f-on1vKKZoHpVq7eR2x04U_d4=/800x600/filters:no_upscale()/https://public-media.si-cdn.com/filer/28/bc/28bc19a4-ec88-4e71-9ff2-19efc1375e6c/ap_18295547401274.jpg")!

class NonBackEvent {
    
    func getEvents() -> [Event] {
        var events = [Event]()
        
        var members = [User]()

        members.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        members.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        members.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        members.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        
        let creator = User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200)
        let preUsers = EventPreUsers(users: members, count: 50)
        //UserData.saveUserData(user: creator)
        
        
        for i in 0...40 {
            let coordinate = Coordinate(destination: "Costa", latitude: -33.86 + Double(i), longitude: 151.20)
            let event = SimpleEvent(id: 1, titleName: "Event\(i)", description: "Super",numberOfLikes : 300, images:  [imageGlobalURL], creator: creator, preUsers: preUsers, coordinates: coordinate, coordinate: CLLocationCoordinate2D(latitude: 21.283921 + Double(i)/1000, longitude: -157.831661 + Double(i)/1000))
            events.append(event)
        }
        
        return events
    }
    
    func getPeople() -> [User]{
        var people = [User]()
        people.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        people.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        people.append(User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200))
        
        return people
    }
}
