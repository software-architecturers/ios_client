//
//  AuthEndPoint.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/21/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation


public enum AuthApi {
    case logInUser(userIdentifier : String, password : String)
    case refreshToken
}

extension AuthApi: EndPointType {
    
    var environmentBaseURL : String {
        switch AuthManager.environment {
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
        case .logInUser:
            return "/auth/login"
        case .refreshToken:
            return "/auth/token"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .logInUser:
            return .post
        case .refreshToken:
            return .post
        }
    }
    
    var task: HTTPTask {
        
        switch self {
        case .logInUser(let userIdentifier, let password):
            return .requestParameters(bodyParameters: ["login":userIdentifier, "password":password], bodyEncoding: .jsonEncoding, urlParameters: nil)
        case .refreshToken:
            return .requestParameters(bodyParameters: ["token":TokenManager.getRefreshToken()!], bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
        
    }

    var headers: HTTPHeaders? {
        return nil
    }
    
}
