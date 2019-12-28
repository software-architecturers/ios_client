//
//  Network.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/22/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

class Network {
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...403: return .outDatedToken
        case 404...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}


enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case oldAccessToken = "Should refresh access_token"
    case serverRip = "Server is RIP"
}

enum Result<String>{
    case success
    case outDatedToken
    case failure(String)
}
