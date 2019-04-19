//
//  EndPointType.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/2/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation


protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}



