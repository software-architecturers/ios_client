//
//  EventsMapViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/18/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

//import Foundation
//import UIKit
//import GoogleMaps
//
//class EventsMapViewController : UIViewController, GMSMapViewDelegate, GMUClusterManagerDelegate {
//    var bottomSheetVC : BottomAnimatedViewController!
//    //private var mapView: GMSMapView!
//    private var clusterManager: GMUClusterManager!
//    
//    var mapView = GMSMapView()
//    var events : [Event]?
//    let nonBackEventHelper = NonBackEvent()
//    var eventHelper = EventHelper()
//    
//    let kClusterItemCount = 100
//    let kCameraLatitude = -33.8
//    let kCameraLongitude = 151.2
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addBottomAnimatedView()
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        //reqeuest -> in closure \_
//        events = nonBackEventHelper.getEvents()
//        //ckeck if events new... if yes -> update
//        if events != nil {
//            setUpCluster()
//        }
//    }
//    
//    private func setUpCluster(){
//        // Set up the cluster manager with the supplied icon generator and
//        // renderer.
//        let iconGenerator = GMUDefaultClusterIconGenerator()
//        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
//        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
//                                                 clusterIconGenerator: iconGenerator)
//        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
//                                           renderer: renderer)
//        
//        // Generate and add random items to the cluster manager.
//        generateClusterItems()
//        
//        // Call cluster() after items have been added to perform the clustering
//        // and rendering on map.
//        clusterManager.cluster()
//    }
//    
//    private func generateClusterItems() {
//        for event in events! {
//            let lat = event.getCoordinates().latitude
//            let lng = event.getCoordinates().longitude
//            let name = "Item"
//            let item =
//                POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name)
//            item.event = event
//            
//            clusterManager.add(item)
//        }
//    }
//    
//    /// Returns a random value between -1.0 and 1.0.
//    private func randomScale() -> Double {
//        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
//    }
//
//    
//    override func loadView() {
//
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86 , longitude: 151.20, zoom: 6.0)
//        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.delegate = self
//        view = mapView
//        
//    }
//    
//    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        
//        if let poiItem = marker.userData as? POIItem {
//            print("You tapped : \(poiItem.event.getCoordinates()),\(poiItem.event.getTitle())")
//            
//            if let eventViewController = eventHelper.getEventViewController(by: poiItem.event) {
//                showView(with: nil)
//                //self.navigationController?.pushViewController(eventViewController, animated: true)
//                
//            }
//            else{
//                print("Something wrong!")
//            }
//        } else {
//            NSLog("Did tap a normal marker")
//        }
//        
//        return false
//    }
//    
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        //Write your code here...
//        hideView()
//        print(coordinate)
//    }
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        print("moved")
//    }
//    
//    
//}
//
//
/////add bottom animated view ////
//
//extension EventsMapViewController {
//    
//    func addBottomAnimatedView(){
//        
//        // 1- Init bottomSheetVC
//        bottomSheetVC = BottomAnimatedViewController()
//        
//        // 2- Add bottomSheetVC as a child view
//        self.addChild(bottomSheetVC)
//        self.view.addSubview(bottomSheetVC.view)
//        bottomSheetVC.didMove(toParent: self)
//        
//        // 3- Adjust bottomSheet frame and initial position.
//        let height = view.frame.height
//        let width  = view.frame.width
//        bottomSheetVC.view.frame = CGRect(x: 0, y: 1000, width: width, height: height)
//    }
//    
//    func showView(with events : [Events]?){
//        UIView.animate(withDuration: 0.3) {
//            let yComponent = Device.safeHeight(with : self.view) - 200
//            self.bottomSheetVC.view.frame = CGRect(x: 0, y: yComponent, width: self.view.frame.width, height: self.view.frame.height)
//        }
//    }
//    
//    func hideView(){
//        UIView.animate(withDuration: 0.3) {
//            let yComponent = Device.safeHeight(with : self.view)
//            self.bottomSheetVC.view.frame = CGRect(x: 0, y: yComponent, width: self.view.frame.width, height: self.view.frame.height)
//        }
//    }/
//}
