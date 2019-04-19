//
//  EventEndPoint.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/3/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}
//add func-requests here
public enum EventApi {
    case newEvents()
    case postEvent(title: String, description: String)
}

extension EventApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://10.241.129.10:8080"
        case .qa: return "http://10.241.129.10:8080"
        case .staging: return "https://pure-cliffs-59123.herokuapp.com"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .newEvents:
            return "info/new-events-create/"
        case .postEvent:
            return "/api/events/add"
        }
        
        
        
    }
    
    var httpMethod: HTTPMethod {// добавить switch (get/post)
        switch self {
        case .newEvents:
            return .get
        case .postEvent:
            return .post
        }
    }
    
    var task: HTTPTask {
        
        switch self {
        case .newEvents():
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: ["someInfo":"someInfo"])
        case .postEvent(let title,let desc):
            return .requestParametersAndHeaders(bodyParameters: ["title":title, "description":desc], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: ["someInfo":"someInfo"])
        default:
            return .request
        }
        
    }
    
    var headers: HTTPHeaders? {
        return nil // access_token!!!!
    }
}

