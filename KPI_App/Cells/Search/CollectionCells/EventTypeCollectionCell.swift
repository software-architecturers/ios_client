//
//  EventTypeCollectionCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/7/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//
import Foundation
import UIKit

class EventTypeCollectionCell : BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    var homeControllernavigationController: UINavigationController?
    let nonBackEventHelper = NonBackEvent()
    let cellId = "EventSearchCell"
    var events = [Event]()
    let eventHelper = EventHelper()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventSearchCell
        let event = events[indexPath.row]
        cell.configureCell(with: event)
        //cell.textLabel?.text = event.getTitle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: .navigateVC, object: self, userInfo: ["event" : events[indexPath.row]])
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    lazy var tableView : UITableView =  {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = #colorLiteral(red: 0.909638479, green: 0.909638479, blue: 0.909638479, alpha: 1)
        tv.register(EventSearchCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    func setupTableView(){
        addSubview(tableView)
        tableView.zeroConstraint(with: self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        //tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        //tableView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        events = nonBackEventHelper.getEvents()
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: .hideKeyboard, object: self, userInfo: nil)
    }
    
    
    override func setupViews(){
        setupTableView()
        backgroundColor = #colorLiteral(red: 0.909638479, green: 0.909638479, blue: 0.909638479, alpha: 1)
    }
    
    
    
}
