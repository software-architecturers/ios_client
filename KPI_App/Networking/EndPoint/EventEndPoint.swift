//
//  EventEndPoint.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/3/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

//add func-requests here
public enum EventApi {
    case getEvents(page: Int, size : Int)
    case postEvent(title: String, description: String)
    case getMapBoundsEvents(location : BoundsLocation)
    case getEventsBySeach(query : String)
    case visitEvent(id : Int)
}

extension EventApi: EndPointType {
    
    var environmentBaseURL : String {
        switch EventManager.environment {
        case .production: return "https://events-core.herokuapp.com"
        case .qa: return "https://events-core.herokuapp.com"
        case .staging: return "https://events-core.herokuapp.com"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getEvents:
            return "/api/events"
        case .postEvent:
            return "/api/events/add"
        case .getMapBoundsEvents:
            return "/api/maps/events"
        case .getEventsBySeach(_):
            return "/api/events/find"
        case .visitEvent(let id):
            return "/api/events/visit/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getEvents:
            return .get
        case .postEvent:
            return .post
        case .getMapBoundsEvents:
            return .get
        case .getEventsBySeach:
            return .get
        case .visitEvent:
            return .put
        }
    }
    
    var task: HTTPTask {
        
        switch self {
        case .getEvents(let page, let size):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["page" : page, "limit" : size], additionHeaders: nil)
            
        case .postEvent(let title,let desc):
            return .requestParametersAndHeaders(bodyParameters: ["title":title, "description":desc], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: nil)
            
        case .getMapBoundsEvents(let location):
            let params = ["leftBotLatitude": location.leftBottomLatitude,
                          "leftBotLongitude": location.leftBottomLongitude,
                          "rightTopLatitude": location.rightTopLatitude,
                          "rightTopLongitude": location.rightTopLongitude]
            
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params)
            
        case .getEventsBySeach(let query):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["q": query])
        case .visitEvent:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization":TokenManager.getToken() ?? ""]
    }

}

