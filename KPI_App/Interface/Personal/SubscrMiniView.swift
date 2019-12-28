//
//  SubscriberMiniView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

enum Subr : String{
    case subscribers = "Подписки"
    case subscriptions = "Подписчики"
}

class SubscrMiniView : UIView {
    
    var viewWidthSize = CGFloat()
    let topContraint = CGFloat(5)
    let bottomConstraint = CGFloat(5)
    var subrType : Subr!
    
    lazy var subScriberCountLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10"
        label.numberOfLines = 1
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
    lazy var subrLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
    func setupView(width : CGFloat, subr : Subr, count : Int){
        viewWidthSize = width/3
        subrType = subr
        subrLabel.text = subr.rawValue
        subScriberCountLabel.text = String(count)
        
        self.widthAnchor.constraint(equalToConstant: viewWidthSize).isActive = true
        
        subScriberCountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subScriberCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topContraint).isActive = true
        subScriberCountLabel.widthAnchor.constraint(equalToConstant: viewWidthSize).isActive = true
        
        subrLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subrLabel.topAnchor.constraint(equalTo: subScriberCountLabel.bottomAnchor, constant: 5).isActive = true
        subrLabel.widthAnchor.constraint(equalToConstant: viewWidthSize).isActive = true
        
        //self.layOutSubViews - Erroorororororoo!!!!
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        
        
    }
}
