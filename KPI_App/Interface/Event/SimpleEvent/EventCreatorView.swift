//
//  EventCreatrorView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EventCreatorView : UIView {
    let creatorImageSize : CGFloat = 80
    
    var creator : User
    
    init(creator : User ) {
        self.creator = creator
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setupView()
        
    }
    
    private func setupView(){
        addSubview(creatorImage)
        creatorImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        creatorImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        creatorImage.widthAnchor.constraint(equalToConstant: creatorImageSize).isActive = true
        creatorImage.heightAnchor.constraint(equalToConstant: creatorImageSize).isActive = true
        
        addSubview(creatorName)
        creatorName.leftAnchor.constraint(equalTo: creatorImage.rightAnchor, constant: 25).isActive = true
        creatorName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        creatorName.centerYAnchor.constraint(equalTo: creatorImage.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var creatorImage : UIImageView = {
        let cIv = UIImageView()
        cIv.kf.setImage(with: creator.imageURL)
        cIv.layer.borderWidth = 1.0
        cIv.layer.masksToBounds = false
        cIv.layer.borderColor = UIColor.red.cgColor
        cIv.clipsToBounds = true
        cIv.layer.cornerRadius = creatorImageSize / 2
        cIv.translatesAutoresizingMaskIntoConstraints = false
        return cIv
    }()
    
    private lazy var creatorName : UILabel = {
        let cN = UILabel()
        cN.text = creator.firstName
        cN.textColor = .black
        cN.translatesAutoresizingMaskIntoConstraints = false
        
        return cN
    }()
}
