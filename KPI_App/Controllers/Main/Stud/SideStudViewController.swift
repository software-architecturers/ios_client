//
//  SideStudViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 2/13/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class SideStudViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var students: Array<StudentTableRows>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SideStudViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studCell", for: indexPath) as! StudRowTableViewCell
        cell.configureForRowStud(students[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let animal = students[indexPath.row]
        //delegate?.didSelectAnimal(animal)
        if students[indexPath.row].title == "First"{
            presentLoginScreenViewController()
        }
    }
    private func presentLoginScreenViewController() {
        let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LogInNavi")
        self.present(loginVC, animated: true, completion: nil)
    }
}

// Mark: Table View Delegate
