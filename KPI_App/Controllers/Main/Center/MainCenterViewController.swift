//
//  MainCenterViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 2/13/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class MainCenterViewController: UIViewController {

    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var eventTableView: UITableView!
    var delegate: MainCenterViewControllerDelegate?
    //var events: Array<Events>!
    
    ////////////////////
    var newEvents = [Event]()
    ////////////////////
    
    var networkManager = NetworkManager()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        networkManager.getNewEvents(){ events, error in
//            
//            if let error = error {
//                print(error)
//            }
//            if let some = events{
//                print(some)
//            }
//        }
        
        networkManager.postEvent(title: "Event1", desc: "SomeInfoAboutEvent1"){ error in
            
            if let error = error{
                print(error)
            }
        }
        networkManager.postEvent(title: "Event2", desc: "SomeInfoAboutEvent2"){ error in
            
            if let error = error{
                print(error)
            }
        }
        
        
//        let eventService = EventsService()
//        eventService.delegate = self
//        eventService.getAllEvents()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showLeftStud(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
    

}

extension MainCenterViewController: UITableViewDelegate, UITableViewDataSource{
    
//    func didReceiveEventImage(eventImage: ImageIdEvent) {
//
//         DispatchQueue.main.async {
//            if let eventIndex = self.newEvents.firstIndex(where: {$0.returnEventID() == eventImage.id}){
//                if let cell = self.eventTableView.cellForRow(at: IndexPath(row: eventIndex, section: 0)) as? EventTableViewCell{
//
//                cell.eventImage.image = eventImage.image
//
//            }
//        }
//
//        }
//    }
//
//    func didReceiveData(_ data: Array<Any>) {
//
//        newEvents = data as! [EventProtocol]
//
//        DispatchQueue.main.async {
//            self.eventTableView.reloadData()
//        }
//
//        //print(newEvents)
////        for event in newEvents{
////            if event.returnTypeOfEvent() == "SimpleEvent" {
////                print("success")
////            }
////        }
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return events.count
        return newEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
       // cell.configureEventCell(event: newEvents[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 420;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEvent", sender: nil)
    }
    
    
}
