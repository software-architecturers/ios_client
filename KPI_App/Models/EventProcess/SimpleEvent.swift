
import Foundation
import CoreLocation

class SimpleEvent: Event {
    
    private let numberOfLikes : Int
    private let isLiked : Bool
    private let descr : String
    private let creator : User
    //private let members : [User]
    private let preUsers : EventPreUsers
    
    
    func getDescription() -> String {return descr}
    func getCreator() -> User {return creator}
    //func getMembers()-> [User] {return members}
    func getPreMembers() -> EventPreUsers {return preUsers}
    
    
    private enum CodingKeys: String, CodingKey {
        case description
        case numberOfLikes = "likes"
        case creator
        case members = "visitors"
        case isLiked = "liked"
    }
    
    init(id: Int, titleName: String, description : String, numberOfLikes: Int, images : [URL], creator : User, preUsers : EventPreUsers, coordinates : Coordinate, coordinate : CLLocationCoordinate2D) {
        self.descr = description
        self.numberOfLikes = numberOfLikes
        self.creator = creator
        self.preUsers = preUsers
        self.isLiked = false
        super.init(id: id, images: images, titleName: titleName, coordinates: coordinates, coordinate: coordinate, startDate : "Пятничка")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.descr = try container.decode(String.self, forKey: .description)
        self.numberOfLikes = try container.decode(Int.self, forKey: .numberOfLikes)
        self.creator = try container.decode(User.self, forKey: .creator)
        self.preUsers = try container.decode(EventPreUsers.self, forKey: .members)
        self.isLiked = try container.decode(Bool.self, forKey: .isLiked)
        
        try super.init(from: decoder)
    }
    
    
}
