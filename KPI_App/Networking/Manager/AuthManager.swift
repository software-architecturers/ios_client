//
//  AuthManager.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/21/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

struct AuthManager {
    
    static let environment : NetworkEnvironment = .staging
    static let EventAPIKey = ""
    let router = Router<AuthApi>()
    
    private static var isRefreshing : Bool = false
    
    static func getRefreshStatus() -> Bool {
        return isRefreshing
    }
    static func setRefreshStatus(_ status : Bool){
        isRefreshing = status
    }
    
    func logInUser(firstTime : Bool = true, userIdentifer:String, password:String,completion: @escaping (_ token : Token?, _ refreshToken: Token?, _ error: String?)->()){
        router.request(.logInUser(userIdentifier: userIdentifer, password: password)) { data, response, error in
            if error != nil {
                completion(nil, nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = Network.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any]
                        if let token = json?["accessToken"] as? String,
                            let refreshToken = json?["refreshToken"] as? String{
                            completion(token, refreshToken, nil)
                        }
                        else{
                            completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    
                    }catch {
                        print(error)
                        completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(nil, nil, networkFailureError)
                case .outDatedToken:
                    completion(nil, nil, NetworkResponse.authenticationError.rawValue)
                }
            }
        }
    }
    
    
     func refreshToken(completion: @escaping ( _ error: String?)->()){
        
        TokenManager.setTokenStatus(status: false)
        AuthManager.setRefreshStatus(true)
        router.request(.refreshToken) { data, response, error in
            if error != nil {
                completion("Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                print(response)
                let result = Network.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any]
                        if let token = json?["accessToken"] as? String,
                            let refreshToken = json?["refreshToken"] as? String{
                            print(AuthManager.getRefreshStatus())
                            TokenManager.setToken(token: token)
                            TokenManager.setTokenStatus(status: true)
                            TokenManager.setRefreshToken(refreshToken: refreshToken)
                            completion(nil)
                        }
                        else{
                            completion(NetworkResponse.unableToDecode.rawValue)
                        }
                        
                    }catch {
                        print(error)
                        completion(NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailureError):
                    completion(networkFailureError)
                case .outDatedToken:
                    completion(NetworkResponse.serverRip.rawValue)
                }
            }
        }
    }
}
