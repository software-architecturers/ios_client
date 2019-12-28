//
//  EventProtocol.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 3/30/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum ParseError: Error {
    case notIntValueID
}

class Event: NSObject, Decodable, MKAnnotation, Searchable {
    
    static var hashable: HashableType<Event> { return HashableType(self) }
    
    override func isEqual(_ object: Any?) -> Bool {
        return id == (object as? Event)?.id
    }
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case titleName = "title"
        case coordinates = "location"
        case eventImages = "imagesLinks"
        case startDate
        case visited
    }
    
    private var id : Int
    private var isVisiting : Bool
    private var titleName : String
    private var images : [URL]
    private let coordinates : Coordinate?
    private let startDate : String
    var coordinate: CLLocationCoordinate2D
    
    init( id : Int, images : [URL], titleName : String, coordinates : Coordinate, coordinate : CLLocationCoordinate2D, startDate: String) {
        self.id = id
        self.titleName = titleName
        self.coordinates = coordinates
        self.coordinate = coordinate
        self.images = images
        self.startDate = startDate
        isVisiting = false
        super.init()
    }
    
    func returnEventID() -> Int { return id}
    func getTitle() -> String {return titleName}
    func getCoordinates()->Coordinate {return coordinates!}
    func getEventImage() -> URL {return images.first ?? URL(string: "https://www.adweek.com/wp-content/uploads/2019/08/eventbrite-giantspoon-marketing-CONTENT-2019.jpg")!}
    func getStartDate() -> String {return startDate}
    func getVisit() -> Bool {return isVisiting}
    func setVisit(_ flag : Bool){self.isVisiting = flag}
   
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let titleName = try container.decode(String.self, forKey: .titleName)
        let images = try container.decode([URL].self, forKey: .eventImages)
        let coordinates = try container.decode(Coordinate.self, forKey: .coordinates)
        let startDate = try container.decode(String.self, forKey: .startDate)
        let isVisiting = try container.decode(Bool.self, forKey: .visited)
        
        self.id = id
        self.titleName = titleName
        self.images = images
        self.coordinates = coordinates
        self.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        self.startDate = startDate
        self.isVisiting = isVisiting
    }
}

protocol ModelDelegate: class {
    func didReceiveData(_ data: Array<Any>)
    func didReceiveEventImage(eventImage : ImageIdEvent)
}

