//
//  PersonalViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {
    let userManager : UserManager = UserManager()
    
    let personalView = PersonalView()
    var topAnchor = Device.height / 6
    
    var user : User!

    override func viewDidLoad() {
        super.viewDidLoad()

        userManager.me { [unowned self] (user, error) in
            DispatchQueue.main.async {
                if user != nil{
                    self.user = user!
                    self.setUpView()
                }
                else{
                    print("CABB Error:", error!)
                }
            }
           
        }
//        user = User(id: 1,firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200)
        
        
    }
    
    func setUpView(){
        personalView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(personalView)
        personalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        personalView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        personalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topAnchor).isActive = true
        personalView.setUpView(with : user, topView: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
