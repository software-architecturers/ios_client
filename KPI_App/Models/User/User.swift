//
//  User.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

struct User : Codable, Searchable {
    let id : Int
    let firstName : String
    let secondName : String
    let nickName : String
    let notes : String
    let email : String
    let imageURL : URL?
    let subscribersCount : Int
    let subscriptionsCount  : Int
    
    init(id : Int, firstName: String, secondName : String, nickName: String, notes: String, email: String, imageURL: URL, subscribersCount: Int, subscriptionsCount: Int) {
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.nickName = nickName
        self.notes = notes
        self.email = email
        self.imageURL = imageURL
        self.subscribersCount = subscribersCount
        self.subscriptionsCount = subscriptionsCount
    }
    
}

extension User {
    enum CodingKeys : String, CodingKey{
        case id
        case nickName = "login"
        case email
        case firstName
        case secondName
        case imageURL = "image"
        case subscribersCount = "subscribers"
        case subscriptionsCount = "subscriptions"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        secondName = try container.decode(String.self, forKey: .secondName)
        email = try container.decode(String.self, forKey: .email)
        nickName = try container.decode(String.self, forKey: .nickName)
        notes = ""
        //imageURL = try container.decode(URL.self, forKey: .image)
        imageURL = userGlobalURL
        subscribersCount = 0
        subscriptionsCount = 0
        
        do {
        let subscribersCount1 = try container.decode(Int.self, forKey: .subscribersCount)
        //let subscriptionsCount1 = try container.decode(Int.self, forKey: .subscriptionsCount)
        }catch {
            print("WTFF",error.localizedDescription)
        }
        
    }
}

