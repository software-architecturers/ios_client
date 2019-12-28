//
//  KpiTemplates.swift
//  MacPaw_Project
//
//  Created by Paul Solyanikov on 6/18/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

struct KpiTemplate : Codable{
    
    let isActive : Bool
    let titleName : String
    let request : String
    let index: Int
}
