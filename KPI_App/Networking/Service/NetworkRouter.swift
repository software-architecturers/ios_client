//
//  NetworkRouter.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/3/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
