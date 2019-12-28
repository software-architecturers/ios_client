//
//  CheckFeatures.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/10/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

class CheckFeatures{
    
    func saveEventsTamplates(tamplateEvents :[KpiTemplate]){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(tamplateEvents), forKey: UserDef.eventsTamplates.rawValue)
    }
    
    func getEventsTamplates () -> [KpiTemplate]? {
        
        if let data = UserDefaults.standard.value(forKey:UserDef.eventsTamplates.rawValue) as? Data {
            let tamplates = try? PropertyListDecoder().decode(Array<KpiTemplate>.self, from: data)
            return tamplates
        }
        return nil
    }
    
    func saveEventFeaturesState(tamplateEvents : [KpiTemplate]){
        
        if !tamplateEvents.isEmpty {
            for tplEvent in tamplateEvents {
                if(tplEvent.isActive){
                    UserDefaults.standard.set(true, forKey: Features.events.rawValue)
                    return
                }
            }
        }
        UserDefaults.standard.set(false, forKey: Features.events.rawValue)
    }
    
    func getEventsFeaturesState () -> Bool {
        return UserDefaults.standard.bool(forKey: Features.events.rawValue)
    }
    func getEventsFeaturesCount() -> Int {
        if let templates = getEventsTamplates() {
            var count = 0
            for _ in templates {
                count += 1
            }
            return ( count == 0 ) ? 1 : count
        }
        return 1
        
    }
}

