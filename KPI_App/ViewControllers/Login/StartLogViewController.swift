//
//  StartLogViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/10/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class StartLogViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackgroung()
    }
    
    func setUpBackgroung(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //backgroundImageView.image = UIImage(named: "forrest")
    }

    @IBAction func logInPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "logIn", sender: self)
    }
    @IBAction func signInPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "signIn", sender: self)
    }
}
