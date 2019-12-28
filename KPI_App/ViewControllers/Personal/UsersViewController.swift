//
//  some.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/12/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class UsersViewController : UIViewController {
    
    let cellId = "usersCell"
    let nonBackEventHelper = NonBackEvent()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        return tableView
    }()
    
    var users = [User]()
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        users = nonBackEventHelper.getPeople()
        tableView.zeroConstraint(with: self.view)
        
        
    }
}

extension UsersViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = users[indexPath.row].firstName
        
        return cell
    }
    
    
}
