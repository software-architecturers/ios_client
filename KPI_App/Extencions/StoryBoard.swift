//
//  StoryBoard.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/19/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func main() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func simpleEventViewController() -> SimpleEventViewController? {
        return main().instantiateViewController(withIdentifier: "SimpleEventViewController") as? SimpleEventViewController
    }
    static func mainTabBarController() -> UIViewController? {
        return main().instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBarController
    }
}
