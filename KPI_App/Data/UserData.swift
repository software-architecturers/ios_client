//
//  UserData.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

enum UserProperty : String {
    case user
    case enter
    case token
    case refreshToken
    case tokenStatus
}


class UserData {
    
    static func saveUserData (user : User) -> Bool{
        do {
            try UserDefaults.standard.set(object: user, forKey: UserProperty.user.rawValue)
            return true
        } catch {
            return false
        }
        
    }
    static func getUserData() -> User? {
        do {
            let user = try UserDefaults.standard.get(objectType: User.self, forKey: UserProperty.user.rawValue)
            return user
        } catch {
            return nil
        }
    }
    
    static func setEntered(_ flag : Bool = true){
        UserDefaults.standard.set(flag, forKey: UserProperty.enter.rawValue)
    }
    
    static func isEntered() -> Bool {
        return UserDefaults.standard.bool(forKey: UserProperty.enter.rawValue)
    }
    
}

public typealias Token = String
class TokenManager{
    
    static func setTokenStatus(status : Bool){
        UserDefaults.standard.set(status, forKey: UserProperty.tokenStatus.rawValue)
    }
    static func getTokenStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: UserProperty.tokenStatus.rawValue)
    }
    
    static func setToken(token : Token){
        let token = "Bearer " + token
        UserDefaults.standard.set(token, forKey: UserProperty.token.rawValue)
    }
    static func getToken() -> Token? {
        return UserDefaults.standard.string(forKey: UserProperty.token.rawValue)
    }
    
    static func setRefreshToken(refreshToken : Token){
        let refreshToken = refreshToken
        UserDefaults.standard.set(refreshToken, forKey: UserProperty.refreshToken.rawValue)
    }
    static func getRefreshToken() -> Token? {
        return UserDefaults.standard.string(forKey: UserProperty.refreshToken.rawValue)
    }
}

