//
//  NetworkManager.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/3/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

var events = """
{
"events": [
{
"type": "simpleEvent",
"id":"3",
"simpleEventField": "HEEY"
},
{
"type": "advEvent",
"id": "4"
},
{
"type": "simpleEvent",
"id": "5",
"simpleEventField": "HEEY"
}
]
}
""".data(using: .utf8)!

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}


enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let environment : NetworkEnvironment = .production
    static let EventAPIKey = ""
    let router = Router<EventApi>()
    
    
    func getNewEvents( completion: @escaping (_ event: [Event]?,_ error: String?)->()){
        router.request(.newEvents()) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        //print(responseData)
            
                        let apiResponse = try JSONDecoder().decode(Events.self, from: events)// responceData
                        completion(apiResponse.events,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func postEvent(title:String, desc:String,completion: @escaping (_ error: String?)->()){
        router.request(.postEvent(title: title, description: desc)) { data, response, error in
            if error != nil {
                completion("Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any]
                        print("start")
                        print("",json)
//                        let apiResponse = try JSONDecoder().decode(Events.self, from: events)// responceData
                        completion(nil)
                    }catch {
                        print(error)
                        completion(NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion( networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
