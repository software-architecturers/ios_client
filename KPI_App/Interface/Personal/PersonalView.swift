//
//  File.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class PersonalView : UIView {
    
    var topView: UIViewController?
    let topContraint = CGFloat(25)
    let bottomConstraint = CGFloat(50)
    
    var personalImageSize = CGFloat()
    lazy var personalImage : UIImageView = {
        let persImage = UIImageView()
        persImage.layer.masksToBounds = false
        persImage.layer.borderColor = UIColor.black.cgColor
        persImage.layer.cornerRadius = personalImageSize/2
        persImage.clipsToBounds = true
        persImage.contentMode = ContentMode.scaleAspectFill 
        persImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(persImage)
        return persImage
    }()
    
    lazy var perosnalLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
    lazy var perosnalNickLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
    lazy var peronalDescr : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
     var subscriberMiniView = SubscrMiniView()
     var subscriptionMiniView = SubscrMiniView()
       
    
    func setUpView(with user : User, topView : UIViewController) {
        self.topView = topView
        
        self.layoutIfNeeded()
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        personalImageSize = self.bounds.size.width/2
        personalImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        personalImage.topAnchor.constraint(equalTo: self.topAnchor, constant: topContraint).isActive = true
        personalImage.widthAnchor.constraint(equalToConstant: personalImageSize).isActive = true
        personalImage.heightAnchor.constraint(equalToConstant: personalImageSize).isActive = true
        personalImage.kf.setImage(with: user.imageURL)
        
        let personalLabelSize = self.bounds.size.width * 3 / 2
        perosnalLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        perosnalLabel.topAnchor.constraint(equalTo: personalImage.bottomAnchor, constant: 10).isActive = true
        perosnalLabel.widthAnchor.constraint(equalToConstant: personalLabelSize).isActive = true
        perosnalLabel.text = user.firstName + " " + user.secondName
        
        perosnalNickLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        perosnalNickLabel.topAnchor.constraint(equalTo: perosnalLabel.bottomAnchor, constant: 5).isActive = true
        perosnalNickLabel.widthAnchor.constraint(equalToConstant: personalLabelSize ).isActive = true
        perosnalNickLabel.text = user.nickName
        
        let personalDescrSize = self.bounds.size.width - 50
        peronalDescr.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        peronalDescr.topAnchor.constraint(equalTo: perosnalNickLabel.bottomAnchor, constant: 10).isActive = true
        peronalDescr.widthAnchor.constraint(equalToConstant: personalDescrSize ).isActive = true
        peronalDescr.text = user.notes
        
        self.addSubview(subscriberMiniView); subscriberMiniView.setupView(width: self.bounds.size.width, subr: .subscribers, count: user.subscribersCount) ; subscriberMiniView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subscriptionMiniView); subscriptionMiniView.setupView(width: self.bounds.size.width, subr: .subscriptions, count: user.subscriptionsCount) ; subscriptionMiniView.translatesAutoresizingMaskIntoConstraints = false
        
        subscriberMiniView.topAnchor.constraint(equalTo: peronalDescr.bottomAnchor, constant: 20).isActive = true
        subscriberMiniView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        subscriptionMiniView.topAnchor.constraint(equalTo: peronalDescr.bottomAnchor, constant: 20).isActive = true
        subscriptionMiniView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        let subscriberViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSubscriber(_:)))
        subscriberMiniView.addGestureRecognizer(subscriberViewTap)
        
        let subscriptionViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSubscription(_:)))
        subscriptionMiniView.addGestureRecognizer(subscriptionViewTap)

        self.layoutSubviews()
        self.heightAnchor.constraint(equalToConstant: self.getViewEstimatedHeight(top: topContraint, bottom: bottomConstraint)).isActive = true
    }
    
    @objc func handleSubscriber(_ sender: UITapGestureRecognizer? = nil) {
        //self.topView?.present(UIViewController(), animated: true, completion: nil)
        self.topView?.navigationController?.pushViewController(UsersViewController(), animated: true)
    }
    
    @objc func handleSubscription(_ sender: UITapGestureRecognizer? = nil) {
        self.topView?.navigationController?.pushViewController(UsersViewController(), animated: true)
    }
    
    
}
