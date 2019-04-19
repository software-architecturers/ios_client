//
//  StudRowTableViewCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 2/14/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class StudRowTableViewCell: UITableViewCell {

    @IBOutlet weak var studRowTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForRowStud(_ stud: StudentTableRows) {
       
        studRowTitle.text = stud.title
    }

}
