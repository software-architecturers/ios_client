//
//  EventViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/8/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

import UIKit
import Kingfisher

class SimpleEventViewController : EventViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    var event : SimpleEvent!
    
    
    //let eventHelper = EventHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9266933693, green: 0.9266933693, blue: 0.9266933693, alpha: 1)
        setupScrollView()
        setupViews()
    }
    override func setEvent(event: Event) {
        self.event = event as? SimpleEvent
        descriptionLabel.text = self.event.getDescription()
        
        placeTimeView.setLabels(time: event.getStartDate(), place: event.getCoordinates().destination)
        
        
    }
    func setupScrollView(){
        print(event.getCoordinates())
        //scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        contentView.addSubview(eventImage)
        let firstView = UIView()
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        eventImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        eventImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        eventImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        eventImage.heightAnchor.constraint(equalToConstant: Device.height/2).isActive = true
        
        contentView.addSubview(mainSEventView)
        mainSEventView.topAnchor.constraint(equalTo: eventImage.bottomAnchor).isActive = true
        mainSEventView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainSEventView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        contentView.addSubview(eventCreatorView)
        eventCreatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        eventCreatorView.topAnchor.constraint(equalTo: mainSEventView.bottomAnchor, constant: 10).isActive = true
        eventCreatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        eventCreatorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        contentView.addSubview(placeTimeView)
        placeTimeView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        placeTimeView.topAnchor.constraint(equalTo: eventCreatorView.bottomAnchor, constant: 10).isActive = true
        placeTimeView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(descriptionView)
        descriptionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionView.topAnchor.constraint(equalTo: placeTimeView.bottomAnchor, constant: 20).isActive = true
        descriptionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 15).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -20).isActive = true
        
        descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    private lazy var eventImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "eventImg")
        imageView.kf.setImage(with: event.getEventImage())
        return imageView
    }()
    
    
    private var placeTimeView : PlaceTime = {
        let pl = PlaceTime()
        pl.translatesAutoresizingMaskIntoConstraints = false
        return pl
    }()
    
   
    private lazy var eventCreatorView : UIView = {
        let cV = EventCreatorView(creator: event.getCreator())
        cV.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleCreatorTap(_:)))
        cV.addGestureRecognizer(tap)
        return cV
    }()
    
    @objc func handleCreatorTap(_ sender: UITapGestureRecognizer? = nil) {
        let userViewController = LoggedUserViewController()
        userViewController.user = event.getCreator()
        self.navigationController?.pushViewController(userViewController, animated: true)
        
    }
    
    private let descriptionView : UIView = {
        let descrView = UIView()
        descrView.backgroundColor = .white
        descrView.translatesAutoresizingMaskIntoConstraints = false
        descrView.layer.masksToBounds = false
        descrView.layer.shadowOffset = CGSize(width: 0, height: 3)
        descrView.layer.shadowRadius = 1
        descrView.layer.shadowOpacity = 0.1
        return descrView
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let descrL = UILabel()
        descrL.textColor = .black
        descrL.numberOfLines = 0
        descrL.text = event.getDescription()
        descrL.translatesAutoresizingMaskIntoConstraints = false
        return descrL
    }()
    
    lazy var mainSEventView : MainSEventView = {
        let mainSEView = MainSEventView(event: event, topView: self)
        mainSEView.translatesAutoresizingMaskIntoConstraints = false
        return mainSEView
    }()
    
}
