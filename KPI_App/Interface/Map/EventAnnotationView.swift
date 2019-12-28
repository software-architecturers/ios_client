//
//  EventAnnotationView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/25/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import MapKit

class EventAnnotationView: MKAnnotationView {
    let backAnnotationView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.layer.cornerRadius = view.frame.size.height / 2
        view.backgroundColor = #colorLiteral(red: 0.918900698, green: 0.918900698, blue: 0.918900698, alpha: 1)
        return view
    }()
    
    lazy var annotationView : UIView = {
        let view = UIView(frame: CGRect(x: backAnnotationView.center.x - 12.5, y: backAnnotationView.center.x - 12.5, width: 25.0, height: 25.0))
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.layer.cornerRadius = view.frame.size.height / 2
        return view
    }()
    
    static let ReuseID = "eventAnnotation"
    
    internal override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        clusteringIdentifier = String(describing: EventAnnotationView.self)
        displayPriority = .defaultLow
        collisionMode = .circle
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? setSelectedView() : setUnSelectedView()
    }
    
    func setSelectedView(){
        backAnnotationView.backgroundColor = #colorLiteral(red: 0.2943484071, green: 0.3186974527, blue: 0.3540705677, alpha: 1)
        //annotationView.layer.opacity = 0.5
        image = backAnnotationView.asImage()
    }
    func setUnSelectedView(){
        backAnnotationView.backgroundColor = #colorLiteral(red: 0.918900698, green: 0.918900698, blue: 0.918900698, alpha: 1)
        //annotationView.layer.opacity = 1
        image = backAnnotationView.asImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
    }
}

private extension EventAnnotationView {
    func configure(with annotation: MKAnnotation) {
        backAnnotationView.addSubview(annotationView)
        image = backAnnotationView.asImage()
    }
}

