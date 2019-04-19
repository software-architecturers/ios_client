//
//  LogInViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/10/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var logInCard: UIView!
    let backgroundImageView = UIImageView()
    
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
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "forrest")
        self.view.sendSubviewToBack(backgroundImageView)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "logIn", sender: self)
    }
    @IBAction func signInPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "signIn", sender: self)
    }
}
