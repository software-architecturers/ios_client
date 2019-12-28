//
//  MenuBarCollectionCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/5/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class MenuBarCollectionCell: BaseCollectionCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.black
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    override func setupViews() {
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
