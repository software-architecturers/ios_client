//
//  EventClusterView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/25/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import MapKit

//  MARK: Battle Rapper Cluster View
internal final class EventClusterView: MKAnnotationView {

    let backAnnotationView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.layer.cornerRadius = view.frame.size.height / 2
        view.backgroundColor = #colorLiteral(red: 0.918900698, green: 0.918900698, blue: 0.918900698, alpha: 1)
        return view
    }()
    
    lazy var annotationView : UIView = {
        let view = UIView(frame: CGRect(x: backAnnotationView.center.x - 15, y: backAnnotationView.center.x - 15, width: 30.0, height: 30.0))
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.layer.cornerRadius = view.frame.size.height / 2
        return view
    }()
    
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: annotationView.frame.width, height: annotationView.frame.height)
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    static let ReuseID = "eventCluster"
    
    internal override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        //centerOffset = CGPoint(x: 0.0, y: -10.0)
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
        fatalError("\(#function) not implemented.")
    }
    
}
private extension EventClusterView {
    func configure(with annotation: MKAnnotation) {
        guard let annotation = annotation as? MKClusterAnnotation else { return }
        let count = annotation.memberAnnotations.count
        backAnnotationView.addSubview(annotationView)
        countLabel.text = String(count)
        annotationView.addSubview(countLabel)
        image = backAnnotationView.asImage()
    }
}

//        image = renderer.image { _ in
//            UIColor.purple.setFill()
//            UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)).fill()
//            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
//            let text = "\(count)"
//            let size = text.size(withAttributes: attributes)
//            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
//            text.draw(in: rect, withAttributes: attributes)
//        }

