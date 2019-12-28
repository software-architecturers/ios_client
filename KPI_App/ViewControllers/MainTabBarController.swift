 //
//  MainTabBarController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/26/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var eventToShow : Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        for viewController in self.viewControllers ?? [] {
            if let navigationVC = viewController as? UINavigationController, let rootVC = navigationVC.viewControllers.first {
                let _ = rootVC.view
            } else {
                let _ = viewController.view
            }
        }
    }
}
