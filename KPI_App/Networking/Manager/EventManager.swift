//
//  NetworkManager.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/3/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

struct EventManager {
    
    static let environment : NetworkEnvironment = .staging
    static let EventAPIKey = ""
    let router = Router<EventApi>()
    
    func getEvents( page : Int, size : Int, completion: @escaping (_ event: [Event]?,_ error: String?)->()){
        
       let api = EventApi.getEvents(page: page, size: size)
        router.request(api) { data, response, error in
            
            JSONParser.parse(of: [SimpleEvent].self, api: api, routerCompletion: (data, response, error), completion: { (result) in
                
                    switch result {
                    case .success(let events) :
                        completion(events, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                })
          }
    }
    
    func getEventsOnMapByLocation(_ location : BoundsLocation, completion: @escaping (_ event: [Event]?,_ error: String?)->()){
        let api = EventApi.getMapBoundsEvents(location: location)
        router.request(api) { (data, response, error) in
            
            JSONParser.parse(of: [SimpleEvent].self, api: api, routerCompletion: (data, response, error), completion: { (result) in
                
                switch result {
                case .success(let events) :
                    completion(events, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
        }
        
    }
    
    func getEventsBySearch(query : String, completion: @escaping (_ events: [Event]?,_ error: String?)->()){
        let api = EventApi.getEventsBySeach(query: query)
        router.request(api) { (data, response, error) in
            
            JSONParser.parse(of: [SimpleEvent].self, api: api, routerCompletion: (data, response, error), completion: { (result) in
                
                switch result {
                case .success(let events) :
                    completion(events, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
        }
    }
    
    func visitEvent(eventId : Int ,completion: @escaping (_ error: String?)->()){
        let api = EventApi.visitEvent(id: eventId)
        router.request(api) { (data, response, error) in
            if let response = response as? HTTPURLResponse{
                 let result = Network.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                case .outDatedToken:
                    completion("outDatedToken")
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
                let result = Network.handleNetworkResponse(response)
                switch result {
                case .success:
                    completion(nil)
                case .failure(let networkFailureError):
                    completion( networkFailureError)
                case .outDatedToken:
                    print("Should update token")
                }
            }
        }
    }
}
