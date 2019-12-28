//
//  EventTypeViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/8/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit
import UIScrollView_InfiniteScroll



class EventTypeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var eventTableView: UITableView!
    var page : Int = 0
    
     var networkManager: EventManager = EventManager()
    
    let nonBackEventHelper = NonBackEvent()
    let eventHelper = EventHelper()
    
    var pageUrl : URL!
    
    var events = [Event]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        let event = events[indexPath.row]
        //на будущее сделать switch case на simpleEvent / AdvEvent
        if let simpleEvent = event as? SimpleEvent {
            cell.createView(event: simpleEvent, topView : self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (Device.width - 50)/3*4 + 15
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let eventViewController = eventHelper.getEventViewController(by: events[indexPath.row]) {
            self.navigationController?.pushViewController(eventViewController, animated: true)
        }
        else{
            print("Something wrong!")
        }
    }
    
    override func viewDidLoad() {
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.backgroundColor = #colorLiteral(red: 0.9266933693, green: 0.9266933693, blue: 0.9266933693, alpha: 1)
        eventTableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        eventTableView.infiniteScrollIndicatorMargin = 0
        eventTableView.infiniteScrollTriggerOffset = 500
        
        NotificationCenter.default.addObserver(self, selector: #selector(enteredEvent(_:)), name: .enterEvent, object: nil)
        
        //infinite scroll handler
        eventTableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            self?.networkManager.getEvents(page: self!.page, size: 4) { (events, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        print(error!)
                    }
                    else{
                        print(events!)
                        self?.reloadEventTableView(events: events!)
                    }
                    tableView.finishInfiniteScroll()
                }
            }
        }
        //events = nonBackEventHelper.getEvents()
        eventTableView.beginInfiniteScroll(true)
    }
    
    @objc func enteredEvent(_ notification:Notification) {
        if let visited_event = notification.userInfo?["event"] as? Event {
//            for i in 0..<events.count {
//                if visited_event.returnEventID() == events[i].returnEventID(){
//                    //events[i] = visited_event
//                    DispatchQueue.main.async {
//                        //self.eventTableView.reloadData()
//                        return
//                    }
//                }
//            }
        }
        
    }
    
    fileprivate func reloadEventTableView(events : [Event]) {
        
        let eventCount = self.events.count
        let (start, end) = (eventCount, events.count + eventCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        
        self.events.append(contentsOf: events)
        self.page += 1
        
        self.eventTableView.beginUpdates()
        self.eventTableView.insertRows(at: indexPaths, with: .automatic)
        self.eventTableView.endUpdates()
    }
    
    
    func setUpController(pgUrl : URL) { self.pageUrl = pgUrl}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEvent" {
            if let eventViewController = segue.destination as? SimpleEventViewController {
                let index = self.eventTableView.indexPathForSelectedRow?.row
                
                eventViewController.event = events[index!] as? SimpleEvent
                
            }
        }
    }
}
