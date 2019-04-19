//
//  EventProtocol.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 3/30/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

enum ParseError: Error {
    case notIntValueID
}

class Event: Decodable {
    
    private var id : Int
    private var type : String
    private var image : UIImage?
    
    func returnTypeOfEvent() -> String {return type}
    func returnEventID() -> Int { return id}
    func setImage(image: UIImage) {
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let id = try container.decode(String.self, forKey: .id)
        //let indId: Int?
        if let intId = Int(id){
            self.type = type
            self.id = intId
        }
        else{throw ParseError.notIntValueID}
        
        
        //try super.init(from: decoder)
    }
}

protocol ModelDelegate: class {
    func didReceiveData(_ data: Array<Any>)
    func didReceiveEventImage(eventImage : ImageIdEvent)
}

