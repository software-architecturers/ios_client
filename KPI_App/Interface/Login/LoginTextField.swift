//
//  LoginTextField.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 4/10/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit


class LoginTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(white: 231 / 255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 7)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

