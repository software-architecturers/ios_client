//
//  MapViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/24/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var mapChangedFromUserInteraction = false
    lazy var bottomSheetVC : BottomAnimatedViewController = {
        let bottAnmVC = BottomAnimatedViewController()
        bottAnmVC.delegate = self
        return bottAnmVC
    }()
    
    lazy var aloneEventBar : AloneEventBar = {
        let alneEvBar = AloneEventBar(frame: CGRect(x: 0, y: -200, width: Device.width, height: Device.statusBarHeight + 50))
        alneEvBar.delegate = self
        return alneEvBar
    }()
    
    enum MapState {
        case map
        case event
    }
    var mapState : MapState = .map
    var aloneEvent : Event? = nil
    
    var currentState: SlideOutState = .hidden
    
    var events : [Event] = [Event]()
    let eventsManager : EventManager = EventManager()
     let nonBackEventHelper = NonBackEvent()
    
    let regionRadius: CLLocationDistance = 500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
                                                    mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func changeMap(_ notification:Notification) {
        if let event = notification.userInfo?["event"] as? Event {
            mapState = .event
            removeAllAnnotations()
            showAloneEvent(event)
            mapView.addAnnotation(event)
            let initialLocation = CLLocation(latitude: event.coordinate.latitude, longitude: event.coordinate.longitude)
            centerMapOnLocation(location: initialLocation)
        }
        
    }
    
    func  showAloneEvent(_ event : Event){
        aloneEvent = event
        aloneEventBar.setEvent(with: event)
        aloneEventBar.frame = CGRect(x: 0, y: 0, width: Device.width, height: Device.statusBarHeight + 50)
    }
    
    func getEventsByLocation() {
        
//        print("location : \(getMapBounds(mapView!.visibleMapRect))")
//        removeAllAnnotations()
//        events = nonBackEventHelper.getEvents()
//        if events != nil{ mapView.addAnnotations(events!)}
        
        let mapBounds = getMapBounds(mapView!.visibleMapRect)
        eventsManager.getEventsOnMapByLocation(mapBounds) { (events, error) in
            if error != nil { print(error!)} else {
                DispatchQueue.main.async { [unowned self] in
                    //self.removeAllAnnotations() ; self.events = events!
                    let setOldEvents = self.events
                    var setNewEvents = events!
                    
             
                    
                    let eventsToStay: Array<Event> = setOldEvents.filter(setNewEvents.contains)
                    //setNewEvents.subtract(setOldEvents)
                    let result = setNewEvents.filter { !setOldEvents.contains($0) }
                    print(result, eventsToStay)
                    var count = 0
                    for annotation in self.mapView.annotations{
                        if let annEvent = annotation as? Event{
                            if !eventsToStay.contains(annEvent){
                                self.mapView.removeAnnotation(annotation)
                            }
                            count += 1
                        }
                        
                    }
                    //print(self.mapView.annotations.count, count)
                    self.mapView.addAnnotations(Array(result))
                    self.events = events!
                }
                
            }
        }
        
    }
    
    private func configureMapController(){
        mapView.delegate = self
        view.addSubview(aloneEventBar)
        addBottomAnimatedView()
        registerAnnotationViewClasses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeMap(_:)), name: .showEventOnMap, object: nil)
        configureMapController()
        
        let initialLocation = CLLocation(latitude: 50.4501, longitude: 30.5234)
        centerMapOnLocation(location: initialLocation)
        getEventsByLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(EventAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(EventClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let cluster = annotation as? MKClusterAnnotation{
            return EventClusterView(annotation: cluster, reuseIdentifier: EventClusterView.ReuseID) }
        else{
            return  EventAnnotationView(annotation: annotation, reuseIdentifier: EventAnnotationView.ReuseID)}
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        if currentState == .expanded {
            hideView()
            for annotation in mapView.selectedAnnotations{
                mapView.deselectAnnotation(annotation, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let cluster = view.annotation as? MKClusterAnnotation {
            let clusterEvents = cluster.memberAnnotations as? [Event]
            showView(with: clusterEvents!, isCluster: true)
        }
        else {
            let annotation = view.annotation as? Event
            showView(with: [annotation!], isCluster: false)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
         hideView()
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if mapViewRegionDidChangeFromUserInteraction() && aloneEvent == nil{
            getEventsByLocation()
           
        }
    }
    
    func removeAllAnnotations(){
        mapView.removeAnnotations(mapView!.annotations)
    }
}

extension MapViewController {
    
    
    enum SlideOutState {
        case hidden
        case expanded
    }
    
    func addBottomAnimatedView(){
        // 1- Init bottomSheetVC
        bottomSheetVC = BottomAnimatedViewController()
        
        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    func showView(with events : [Event], isCluster : Bool){
        currentState = .expanded
        let tBheight : CGFloat = isCluster ? 300 : 150
        bottomSheetVC.updateView(with: events, tableViewHeight: tBheight)
        UIView.animate(withDuration: 0.3) {
            let yComponent = Device.safeHeight(with : self.view) + Device.statusBarHeight - tBheight
            self.bottomSheetVC.view.frame = CGRect(x: 0, y: yComponent, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func hideView(){
        print("hideView")
        currentState = .hidden
        UIView.animate(withDuration: 0.3) {
            
            let yComponent = Device.height
            self.bottomSheetVC.view.frame = CGRect(x: 0, y: yComponent, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
}

extension MapViewController : MapBottomDelegate, MapAloneBarDelegate {
    
    
    func cancelBar() {
        aloneEvent = nil
        getEventsByLocation()
    }
    
    func showEvent(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}



