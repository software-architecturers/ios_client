//
//  AloneEventBar.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/29/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class AloneEventBar : UIView {
    
    private let label : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 23)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cancelButton : UIButton = {
        let cancelButt = UIButton()
        cancelButt.setImage(UIImage(named: "delete"), for: .normal)
        cancelButt.addTarget(self, action: #selector(hideBar), for: .touchUpInside)
        cancelButt.translatesAutoresizingMaskIntoConstraints = false
        
        return cancelButt
    }()
    
    var delegate : MapAloneBarDelegate?
    
    private let size : CGFloat
    override init(frame: CGRect) {
        size = (frame.height - Device.statusBarHeight) * 2 / 3
        
        super.init(frame: frame)
        setUpView()
        backgroundColor = .blue
    }
    
    private func setUpView (){
       
        addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: Device.statusBarHeight / 2).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: Device.statusBarHeight / 2).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: cancelButton.leftAnchor, constant: 30).isActive = true
        
    }
    
    @objc func hideBar(){
        delegate?.cancelBar()
        UIView.animate(withDuration: 0.3) {
            let animatedY = Device.statusBarHeight + self.frame.height
            self.frame = CGRect(x: 0, y: -animatedY, width: self.frame.width, height: self.frame.height)
        }
        
    }
    
    func setEvent(with event: Event){
        label.text = event.getTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
