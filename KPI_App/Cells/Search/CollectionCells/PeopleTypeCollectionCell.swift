//
//  PeopleTypeCollectionCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/7/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class PeopleTypeCollectionCell : BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    var homeControllernavigationController: UINavigationController?
    let nonBackEventHelper = NonBackEvent()
    let cellId = "PersonSearchCell"
    var people = [User]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PersonSearchCell
        let user = people[indexPath.row]
        cell.configureCell(with: user)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .navigateVC, object: self, userInfo: ["user" : people[indexPath.row]])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    lazy var tableView : UITableView =  {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = #colorLiteral(red: 0.9313134518, green: 0.9313134518, blue: 0.9313134518, alpha: 1)
        tv.register(PersonSearchCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    func setupTableView(){
        addSubview(tableView)
        tableView.zeroConstraint(with: self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        people = nonBackEventHelper.getPeople()
    }
    
    override func setupViews(){
        setupTableView()
        backgroundColor = #colorLiteral(red: 0.9313134518, green: 0.9313134518, blue: 0.9313134518, alpha: 1)
    }
    
    
}

