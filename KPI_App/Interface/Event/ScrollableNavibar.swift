//
//  ScrollableNavibar.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/5/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class ScrollableNaviBar : UIView, UISearchBarDelegate{
    var delegate : ScrollableNaviBarDelegate?
    let eventManager : EventManager = EventManager()
    let userManager : UserManager = UserManager()
    var currentSection : Int = 0
    
    lazy var search : UISearchBar = {
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        search.delegate = self
        search.showsCancelButton = false
        search.clipsToBounds = true
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(sectionChanged(_:)), name: .sectionEntered, object: nil)
        setUpView()
    }
    
    @objc func sectionChanged(_ notification: Notification)
    {
        if let section = notification.userInfo?["Section"] as? Int {
            currentSection = section
            print(currentSection)
            perform(#selector(self.reload(_:)), with: search, afterDelay: 0.1)
        }
    }
    
    func layOutViews (){
        addSubview(search)
        search.topAnchor.constraint(equalTo: self.topAnchor, constant: Device.statusBarHeight).isActive = true
        search.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        search.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        search.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        search.backgroundImage = UIImage()
        
    }
    
    func setUpView(){
        layOutViews()
        backgroundColor = #colorLiteral(red: 1, green: 0.2307412326, blue: 0.3169002831, alpha: 1)
        search.barTintColor = #colorLiteral(red: 1, green: 0.2307412326, blue: 0.3169002831, alpha: 1)
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //eventManager.router.cancel()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.4)
    }
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        switch currentSection {
        case 0:
            eventManager.getEventsBySearch(query: query) {[unowned self] (events, error) in
                self.delegate?.getResults(with: query, results : events, error : error)
            }
        case 1:
            userManager.getUsersBySearch(query: query) {[unowned self] (users, error) in
                self.delegate?.getResults(with: query, results : users, error : error)
            }
        default:
            print("Unknown section")
        }
        
        
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        search.setShowsCancelButton(true, animated: true)
        delegate?.showSearchVC()
        
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        search.setShowsCancelButton(false, animated: true)
        delegate?.hideSearchVC()
        
    }
    
    func enableCancelButton () {
        for view1 in search.subviews {
            for view2 in view1.subviews {
                if view2 is UIButton {
                    let button = view2 as! UIButton
                    button.isEnabled = true
                    button.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
