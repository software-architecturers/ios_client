//
//  UserEndPoint.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 9/14/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation


//add func-requests here
public enum UserApi {
    case me
    case getUser(id: Int)
    case subscribe(id: Int)
    case getUsersBySearch(query : String)
}

extension UserApi: EndPointType {
    
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
        case .me:
            return "/api/users/me"
        case .getUser(let id):
            return "/users/\(id)"
        case .subscribe(let id):
            return "/subscribe/\(id)"
        case .getUsersBySearch:
            return "/api/users/find"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .me:
            return .get
        case .getUser:
            return .get
        case .subscribe:
            return .put
        case .getUsersBySearch:
            return .get
        }
        
        
    }
    
    var task: HTTPTask {
        
        switch self {
        case .me:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        case .getUser:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        case .subscribe:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        case .getUsersBySearch(let query):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["q":query])
        }
    }
    
    var headers: HTTPHeaders? {
        //print(TokenManager.getToken())
        return ["Authorization":TokenManager.getToken() ?? ""]
    }
    
}

