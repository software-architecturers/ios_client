//
//  LoggedUserViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 10/16/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class LoggedUserViewController : UIViewController {
        let userManager : UserManager = UserManager()
        
        let personalView = PersonalView()
        var topAnchor = Device.height / 6
        
        var user : User!

        override func viewDidLoad() {
            super.viewDidLoad()

            setUpView()
//            userManager.getUser(userId : 3) { [unowned self] (user, error) in
//                DispatchQueue.main.async {
//                    if user != nil{
//                        self.user = user!
//                        self.setUpView()
//                    }
//                    else{
//                        print("CABB Error:", error!)
//                    }
//                }
//
//            }

            
            
        }
        
        func setUpView(){
            self.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1479286281, blue: 0.2444124781, alpha: 1)
            personalView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(personalView)
            personalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            personalView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            personalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topAnchor).isActive = true
            personalView.setUpView(with : user, topView: self)
        }
        
        

}

