//
//  SearchViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/2/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class InterestViewController: UIViewController {
    let eventHelper = EventHelper()
    let searchVc = SearchViewController()
    
    lazy var naviBarHeight = Device.naviBarHeight(with: self)
    
    lazy var scrollableNaviBar : ScrollableNaviBar = {
        let scrNavBar = ScrollableNaviBar(frame: CGRect(x: 0, y: 0, width: Device.width, height: naviBarHeight))
        scrNavBar.delegate = self
        return scrNavBar
    }()
    
    
    
    enum SectionType {
        case event
        case people
    }
    enum ObjectPosition {
        case hidden
        case open
    }
    var naviBarPostion : ObjectPosition = .open
    var bottomVcPosition : ObjectPosition = .hidden
    private var lastContentOffset: CGFloat = 0
    
    var sectionTypes : [SectionType] = [.event, .people]
    lazy var currentSectionType : SectionType = sectionTypes.first!
    
    var searchResults = [Searchable]()
    let nonBackEventHelper = NonBackEvent()

    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(_:)), name: .hideKeyboard, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateVC(_:)), name: .navigateVC, object: nil)
        
        searchTableView.register(InterestEventCell.self, forCellReuseIdentifier: "InterestEventCell")
        searchTableView.register(PersonSearchCell.self, forCellReuseIdentifier: "PersonSearchCell")
        searchResults = nonBackEventHelper.getEvents()
        layOutTableView()
        addSearchVC()
 
    }
    
    @objc func navigateVC(_ notification:Notification) {
        if let event = notification.userInfo?["event"] as? Event {
            if let eventViewController = eventHelper.getEventViewController(by: event) {
                self.navigationController?.pushViewController(eventViewController, animated: true)
            }
        }
        else if let user = notification.userInfo?["user"] as? User {
            if let userViewController = eventHelper.getUserViewController(user: user) {
                self.navigationController?.pushViewController(userViewController, animated: true)
            }
        }
            
       }
    
    @objc func hideKeyboard(_ notification:Notification) {
        self.view.endEditing(true)
        self.scrollableNaviBar.search.endEditing(true)
        //(scrollableNaviBar.search.value(forKey: "_cancelButton") as? UIButton)?.isEnabled = true
        scrollableNaviBar.enableCancelButton()
        
    }
    
    
    func layOutTableView(){
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollableNaviBar)
        searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchTableView.topAnchor.constraint(equalTo: scrollableNaviBar.bottomAnchor).isActive = true
    }
    

}

extension InterestViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var model : CellViewAnyModel
        
        switch currentSectionType {
            
        case .event:
            let event = searchResults[indexPath.row] as! Event
            model = EventTableCellModel(event: event)
        case .people:
            let person = searchResults[indexPath.row] as! User
            model = PersonTableCellModel(person: person)
            
        }
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
        
    }
}

//##############   Custom NaviBar settings     #############//

extension InterestViewController {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !(velocity.y < -0.00001) {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.scrollableNaviBar.frame = CGRect(x: 0, y: -50, width: Device.width, height: self.naviBarHeight)
                self.view.layoutSubviews()
            }, completion: { (_) in
                self.naviBarPostion = .hidden
                
            })
        } else {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.scrollableNaviBar.frame = CGRect(x: 0, y: 0, width: Device.width, height: Device.statusBarHeight + 50)
                self.view.layoutIfNeeded()
                
                
            }, completion: { (_) in
                self.naviBarPostion = .open
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension InterestViewController: ScrollableNaviBarDelegate {
    
    func getResults(with query: String, results: [Searchable]?, error: String?) {
        self.searchVc.getResultsBySearch(with: query, results : results, error : error)
    }
    
    func showSearchVC() {
        if bottomVcPosition == .hidden{
            let height = view.frame.height
            let width  = view.frame.width
            bottomVcPosition = .open
            UIView.animate(withDuration: 0.3) {
                self.searchVc.view.frame = CGRect(x: 0, y: self.naviBarHeight, width: width, height: height - self.naviBarHeight)
            }
        }
        
    }
    
    func hideSearchVC() {
        if bottomVcPosition == .open{
            let height = view.frame.height
            let width  = view.frame.width
            bottomVcPosition = .hidden
            UIView.animate(withDuration: 0.3) {
                self.searchVc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height - self.naviBarHeight)
            }
        }
        
    }
    
    func addSearchVC(){
        self.addChild(searchVc)
        self.view.addSubview(searchVc.view)
        searchVc.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        searchVc.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height - naviBarHeight)
    }
}
