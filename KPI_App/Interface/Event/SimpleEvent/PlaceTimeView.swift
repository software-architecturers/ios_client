//
//  PlaceTimeView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/9/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class PlaceTime : BaseView {
    
    let iconSize : CGFloat = 40
    let viewSize : CGFloat = 50
    
    override func setUpView (){
        backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.1
        
        //////////////////  timeView config  ///////////////
        let timeView = UIView()
        timeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeView)
//        timeView.layer.borderColor = UIColor.red.cgColor
//        timeView.layer.borderWidth = 1
        timeView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        timeView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        timeView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //timeView.heightAnchor.constraint(equalToConstant: viewSize).isActive = true

        timeView.addSubview(timeImageView)
        timeImageView.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 10).isActive = true
        timeImageView.leftAnchor.constraint(equalTo: timeView.leftAnchor, constant: 20).isActive = true
        timeImageView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        timeImageView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        timeView.addSubview(timeLabel)
        timeLabel.leftAnchor.constraint(equalTo: timeImageView.rightAnchor, constant: 25).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: timeView.rightAnchor, constant: -20).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor).isActive = true
        
        timeView.bottomAnchor.constraint(equalTo: timeImageView.bottomAnchor, constant: 10).isActive = true
        
        
        //////////////////  placeView config  ///////////////
        
        let placeView = UIView()
        placeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeView)
//        placeView.layer.borderColor = UIColor.blue.cgColor
//        placeView.layer.borderWidth = 1
        placeView.topAnchor.constraint(equalTo: timeView.bottomAnchor).isActive = true
        placeView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        placeView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //placeView.heightAnchor.constraint(equalToConstant: viewSize).isActive = true

        placeView.addSubview(placeImageView)
        placeImageView.topAnchor.constraint(equalTo: placeView.topAnchor, constant: 10).isActive = true
        placeImageView.leftAnchor.constraint(equalTo: placeView.leftAnchor, constant: 20).isActive = true
        placeImageView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        placeImageView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true

        placeView.addSubview(placeLabel)
        placeLabel.leftAnchor.constraint(equalTo: placeImageView.rightAnchor, constant: 25).isActive = true
        placeLabel.rightAnchor.constraint(equalTo: placeView.rightAnchor, constant: -20).isActive = true
        placeLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor).isActive = true
        
        placeView.bottomAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 10).isActive = true

        self.bottomAnchor.constraint(equalTo: placeView.bottomAnchor).isActive = true
        
        
    }
    
    func setLabels(time: String, place: String){
        timeLabel.text = time
        placeLabel.text = place
    }
    
    private let timeImageView : UIImageView = {
        let tIv = UIImageView(image: UIImage(named: "time-icon"))
        tIv.translatesAutoresizingMaskIntoConstraints = false
        return tIv
    }()
    
    private let timeLabel : UILabel = {
        let tL = UILabel()
        tL.textColor = .black
        tL.numberOfLines = 2
        tL.text = "Пятничка 18:00 31-08-2019 "
        tL.translatesAutoresizingMaskIntoConstraints = false
        return tL
    }()
    
    private let placeImageView : UIImageView = {
        let tIv = UIImageView(image: UIImage(named: "place-icon"))
        tIv.translatesAutoresizingMaskIntoConstraints = false
        return tIv
    }()
    
    private let placeLabel : UILabel = {
        let tL = UILabel()
        tL.textColor = .black
        tL.numberOfLines = 2
        tL.text = "Борщаговская 13 "
        tL.translatesAutoresizingMaskIntoConstraints = false
        return tL
    }()
}
