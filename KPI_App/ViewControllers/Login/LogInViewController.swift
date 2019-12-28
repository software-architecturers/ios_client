//
//  LogInViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/10/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let authManager : AuthManager = AuthManager()
    
    @IBOutlet weak var logInCard: UIView!
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var emailTextVIew: LoginTextField!
    @IBOutlet weak var passwordTextView: LoginTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginView()
    }
    
    func setCircleImg(image: UIView){
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
//        image.image = UIImage(named: imgName)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    }
    
    func setLoginView(){
        setUpBackgroung()
        logInCard.layer.cornerRadius = 7
        logInCard.contentMode = .scaleAspectFill
        logInCard.clipsToBounds = true
        
    }
    
    func setUpBackgroung(){
        view.addSubview(backgroundImageView)
        backgroundImageView.zeroConstraint(with: self.view)
        backgroundImageView.image = UIImage(named: "forrest")
        self.view.sendSubviewToBack(backgroundImageView)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        if emailTextVIew.validate() && passwordTextView.validate() {
            let identifer = emailTextVIew.text!
            let password = passwordTextView.text!
            authManager.logInUser(userIdentifer: identifer, password: password) { (token, refreshToken ,error) in
                if error != nil {
                    self.presentAlertWithTitle(title: "Error" , message: error!, options: "Ok", completion: { (_) in })
                }
                else{
                    UserData.setEntered()
                    DispatchQueue.main.async {
                        TokenManager.setToken(token: token!)
                        TokenManager.setTokenStatus(status: true)
                        TokenManager.setRefreshToken(refreshToken: refreshToken!)
                        guard let sequeViewController = UIStoryboard.mainTabBarController() else{return}
                        self.present(sequeViewController, animated: true, completion: nil)
                    }
                }
            }
        }
        else{
            self.presentAlertWithTitle(title: "Error" , message: "Enter correct Data", options: "Ok", completion: { (_) in
            })
        }
    }
    
}
