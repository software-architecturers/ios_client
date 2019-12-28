//
//  MainSEventView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/14/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class MainSEventView : UIView{
    
    var event : SimpleEvent!
    var topView : UIViewController!
    var eventManager : EventManager = EventManager()
    
    let sideAnchor : CGFloat = 10
    
    private let acceptButton : UIButton = {
        let aBut = UIButton()
        aBut.translatesAutoresizingMaskIntoConstraints = false
        aBut.setTitle("Пойду", for: .normal)
        aBut.setTitleColor(UIColor.black, for: .normal)
        aBut.backgroundColor = #colorLiteral(red: 1, green: 0.2307412326, blue: 0.3169002831, alpha: 1)
        aBut.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        aBut.layer.cornerRadius = 5
        return aBut
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        acceptButton.loadingIndicator(true)
        eventManager.visitEvent(eventId: event.returnEventID()) { [unowned self] (error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.setButton(isVisited: !self.event.getVisit())
                    self.event.setVisit(!self.event.getVisit())
                    NotificationCenter.default.post(name: .enterEvent, object: self, userInfo: ["event" : self.event])
                }
                else{
                    print(error!)
                }
                self.acceptButton.loadingIndicator(false)
            }
            
        }
      
    }
    
    private lazy var titleName: UILabel = {
        let label = UILabel()
        label.text = event.getTitle()
        label.font = UIFont(name: "Helvetica-Bold", size: 22)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let eventUsersView : EventUsersView = {
        let eUV = EventUsersView()
        eUV.translatesAutoresizingMaskIntoConstraints = false
        return eUV
    }()
    
    init(event : SimpleEvent, topView : UIViewController) {
        super.init(frame: CGRect.zero)
        self.event = event
        self.topView = topView
        
        setUpView()
    }
    
    func setUpView(){
        backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.1
        self.addSubview(titleName)
        titleName.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive = true
        titleName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sideAnchor).isActive = true
        titleName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -sideAnchor).isActive = true
        
        self.addSubview(eventUsersView)
        eventUsersView.setUpView(users: event.getPreMembers().users, size: 50)
        eventUsersView.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 20).isActive = true
        eventUsersView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sideAnchor).isActive = true
        eventUsersView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(acceptButton)
        acceptButton.centerYAnchor.constraint(equalTo: eventUsersView.centerYAnchor).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -sideAnchor).isActive = true
        acceptButton.widthAnchor.constraint(equalToConstant: Device.width / 3).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        acceptButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        setButton(isVisited: event.getVisit())
        
    }
    
    func setButton(isVisited : Bool){
        if isVisited {
            self.acceptButton.setTitle("Уже иду!", for: .normal)
            self.acceptButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        else{
            acceptButton.setTitle("Пойду", for: .normal)
            acceptButton.setTitleColor(UIColor.black, for: .normal)
            acceptButton.backgroundColor = #colorLiteral(red: 1, green: 0.2307412326, blue: 0.3169002831, alpha: 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
