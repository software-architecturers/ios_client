//
//  UserDefaults.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 5/15/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

class MyData {
    
    
    func saveMode(_ mode: Bool){
        UserDefaults.standard.set(mode, forKey: "mode")
    }
    
    func getMode() -> Bool{
        if(isKeyPresentInUserDefaults(key: "mode")){
            return UserDefaults.standard.bool(forKey: "mode")
        }
        else{
            self.saveMode(false)
            return false
        }
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
