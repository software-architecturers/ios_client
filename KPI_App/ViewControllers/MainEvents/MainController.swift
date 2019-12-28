//
//  MainController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/8/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class MainController : UIViewController, ACTabScrollViewDataSource, ACTabScrollViewDelegate {
    
    var kpiTemplates : [KpiTemplate]?
    var contentViews = [UIViewController]()
    func numberOfPagesInTabScrollView(_ tabScrollView: ACTabScrollView) -> Int {
        return kpiTemplates!.count
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        
        let label = UILabel()
        label.text = kpiTemplates![index].titleName
        label.textAlignment = .center
        label.sizeToFit() 
        label.frame.size = CGSize(width: label.frame.size.width + 28,
                                  height: label.frame.size.height + 36)
        
        return label
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return contentViews[index].view
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
    }
    
    func tabScrollView(_ tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
    }
    
    @IBOutlet weak var tabScrollView: ACTabScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEventTypes()
        
        if (kpiTemplates != nil) {
             setUpTabScroll()
        }
        else
        {
            presentAlertWithTitle(title: "Temporarily Unavailable", message: "This feature is temporarily unavailable. Try again later", options: "OK") { _ in }
        }
       
    }
    
    func setUpTabScroll (){
        tabScrollView.delegate = self
        tabScrollView.dataSource = self
        tabScrollView.defaultPage = 0
        tabScrollView.arrowIndicator = true
        tabScrollView.tabSectionHeight = 40
        tabScrollView.tabSectionBackgroundColor = UIColor.white
        tabScrollView.contentSectionBackgroundColor = UIColor.white
        tabScrollView.tabGradient = true
        tabScrollView.pagingEnabled = true
        tabScrollView.cachedPageLimit = 0
        
        // create content views from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        for _ in 0 ..< kpiTemplates!.count{
            let vc = storyboard.instantiateViewController(withIdentifier: "EventTypeViewController") as! EventTypeViewController
            
            /* set somethings for vc */
            vc.setUpController(pgUrl: URL(string: "https://google.com")!)
            addChild(vc)
            contentViews.append(vc)
        }

    }
    
    func setUpEventTypes(){
        
        kpiTemplates = [KpiTemplate]()
        kpiTemplates?.append(KpiTemplate(isActive: false, titleName: "Главная", request: "https://google.com", index: 0))
         kpiTemplates?.append(KpiTemplate(isActive: false, titleName: "Лайк", request: "https://google.com", index: 0))
        
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
