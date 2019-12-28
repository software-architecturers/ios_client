//
//  BottomAnimatedViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/22/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class BottomAnimatedViewController: UIViewController {
    
    var tableViewHeight : CGFloat = 0 // default
    var events = [Event]()
    let eventHelper = EventHelper()
    var delegate : MapBottomDelegate!
    let cellIdentifier = "EventSearchCell"
    
    lazy var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Device.width, height: tableViewHeight))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9266933693, green: 0.9266933693, blue: 0.9266933693, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9266933693, green: 0.9266933693, blue: 0.9266933693, alpha: 1)
        tableView.register(EventSearchCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
    }
    
    func updateView(with events : [Event], tableViewHeight : CGFloat) {
        self.events = events
        tableView.frame = CGRect(x: 0, y: 0, width: Device.width, height: tableViewHeight )
        tableView.reloadData()
    }
    
}

extension BottomAnimatedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventSearchCell
        let event = events[indexPath.row]
        cell.configureCell(with: event)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let eventViewController = eventHelper.getEventViewController(by: events[indexPath.row]) {
            self.navigationController?.pushViewController(eventViewController, animated: true)
        }
        else{
            print("Something wrong!")
        }
    }
    
    
}
