//
//  StudentTableRows.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 2/13/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit


struct StudentTableRows {
    
    let title: String
    //let creator: String
    //let image: UIImage?
    
    init(title: String) {
        self.title = title
        //self.creator = creator
        //self.image = image
}
    
    static func studentRows() -> [StudentTableRows] {
        return [
            StudentTableRows(title: "First"),
            StudentTableRows(title: "Second"),
            StudentTableRows(title: "Third")
        ]
    }
}
