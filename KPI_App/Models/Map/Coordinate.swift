//
//  Coordinate.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/19/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

struct Coordinate : Decodable {
    let destination : String
    let latitude : Double
    let longitude : Double
}

public struct BoundsLocation {
    let leftBottomLatitude : Double
    let leftBottomLongitude : Double
    let rightTopLatitude : Double
    let rightTopLongitude : Double
}
