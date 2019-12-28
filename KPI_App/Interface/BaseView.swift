//
//  BaseView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/14/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class BaseView : UIView{

    init() {
        super.init(frame: CGRect.zero)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView (){ fatalError("super")}
}
