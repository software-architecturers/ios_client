//
//  UserManager.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 9/14/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

struct UserManager {
    static let environment : NetworkEnvironment = .staging
    static let EventAPIKey = ""
    let router = Router<UserApi>()
    
    func me(completion: @escaping (_ user: User?,_ error: String?)->()){
        
        let api = UserApi.me
        router.request(api) { data, response, error in
            JSONParser.parse(of: User.self, api: api, routerCompletion: (data, response, error), completion: { (result) in
                switch result {
                case .success(let user) :
                    completion(user, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
        }
    }
    
    func getUser(userId: Int, completion: @escaping (_ user: User?,_ error: String?)->()){
        
        let api = UserApi.getUser(id: userId)
        router.request(api) { data, response, error in
            JSONParser.parse(of: User.self, api: api, routerCompletion: (data, response, error), completion: { (result) in
                switch result {
                case .success(let user) :
                    completion(user, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
        }
    }
    
    
    func getUsersBySearch(query : String, completion: @escaping (_ users: [User]?,_ error: String?)->()){
        let api = UserApi.getUsersBySearch(query: query)
        router.request(api) { (data, response, error) in
            JSONParser.parse(of: [User].self, api: api, routerCompletion: (data, response, error), completion: {(result) in
                switch result {
                case .success(let users) :
                    completion(users, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
        }
    }
}
