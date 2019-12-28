//
//  EventUsersView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/12/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class EventUsersView : UIView {
    
    let noUser = User(id: 1, firstName: "Tommy", secondName : "Shelby", nickName: "@sharp", notes: "Picky Blinder", email: "tommy@blinder.uk", imageURL: userGlobalURL, subscribersCount: 3000, subscriptionsCount: 200)
    
     var plusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica-Light", size: 15)
        return label
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(users : [User], size : CGFloat){

        var userImages = 1
        var position = size
        
        switch users.count {
        case _ where users.count == 3:
            userImages = 3
        case _ where users.count > 3:
            userImages = 3
            plusLabel.text = "+ \(users.count - 3) more"
        case _ where users.count == 2:
            userImages = 2
            position = size/2
        case _ where users.count == 1:
            userImages = 1
            position = 0
        default:
           userImages = 0
        }
        
        var firstUserView = UIImageView()
        for i in 0..<userImages {
            var userView = UIImageView(frame: CGRect(x: position, y: 0, width: size, height: size))
            userView.kf.setImage(with: users[i].imageURL)
            userView.layer.masksToBounds = false
            userView.clipsToBounds = true
            userView.layer.cornerRadius = size / 2
            userView.contentMode = .scaleAspectFill
            userView.layer.borderWidth = 1
            userView.layer.borderColor = UIColor.black.cgColor
            addSubview(userView)
            position = position - size/2
            if i == 0{firstUserView = userView}
        }
        
        if userImages != 0{
            addSubview(plusLabel)
            plusLabel.leftAnchor.constraint(equalTo: firstUserView.rightAnchor, constant: 10).isActive = true
            plusLabel.centerYAnchor.constraint(equalTo: firstUserView.centerYAnchor).isActive = true
        }
        
    }
    
}
