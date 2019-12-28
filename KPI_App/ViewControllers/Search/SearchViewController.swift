//
//  DetailSearchViewController.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/5/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum SectionType {
        case event
        case people
    }
    var sectionTypes : [SectionType] = [.event, .people]
    lazy var currentSectionType : SectionType = sectionTypes.first!
    
        let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 60, height: 60)
        return layout
    }()
   
    lazy var collectionView : UICollectionView = {
        let collView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.backgroundColor = #colorLiteral(red: 0.9313134518, green: 0.9313134518, blue: 0.9313134518, alpha: 1)
        collView.register(EventTypeCollectionCell.self, forCellWithReuseIdentifier: "EventTypeCollectionCell")
        collView.register(PeopleTypeCollectionCell.self, forCellWithReuseIdentifier: "PeopleTypeCollectionCell")
        collView.isPagingEnabled = true
        self.view.addSubview(collView)
        return collView
    }()

    var numberOfItems = 1
    let titles : [String] = ["Events", "People"]
    let cellId = "cellIdCollection"
    var kpiTemplates = [KpiTemplate]()
    let tamplateHelper = CheckFeatures()
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.mainController = self
        mb.eventTemplates = kpiTemplates
        return mb
    }()
    
    func addMenuBar(){
        
        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            configureEventsTemplates()
            setUpCollectionView()
            addMenuBar()
            numberOfItems = kpiTemplates.count
    }
    
    func emptyResults(results: [Searchable]){
        if let eventsCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? EventTypeCollectionCell{
            eventsCell.events = []
            eventsCell.tableView.reloadData()
        }
           else if let peopleCell = self.collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? PeopleTypeCollectionCell{
                peopleCell.people = []
                peopleCell.tableView.reloadData()
            }
    }
    
    func getResultsBySearch(with query : String, results: [Searchable]?, error: String?){
         DispatchQueue.main.async { [unowned self] in
            //print(query ,results, error,results.self)
        if results != nil {
            if results?.isEmpty == false {
            if results is [Event]{
                if let eventsCell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? EventTypeCollectionCell{
                    eventsCell.events = results as! [Event]
                    eventsCell.tableView.reloadData()
                }
            }
            else if results is [User]{
                if let peopleCell = self.collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? PeopleTypeCollectionCell{
                    peopleCell.people = results as! [User]
                    peopleCell.tableView.reloadData()
                }
            }
        
        }
            else{
                self.emptyResults(results: results!)
            }
        }
        else {print(query,error!)}
        }
    }
    
    
    
    func showSorryPage(){
        let alert = UIAlertController(title: "Temporarily Unavailable", message: "This feature is temporarily unavailable. Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureEventsTemplates () {
        kpiTemplates = [KpiTemplate(isActive: true, titleName: "Hello", request: "http://d", index: 0), KpiTemplate(isActive: true, titleName: "Hello2", request: "http://d", index: 1)]
    }
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.zeroConstraint(with: self.view)
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("cell ",indexPath.row)
        
        NotificationCenter.default.post(name: .sectionEntered, object: nil, userInfo: ["Section":indexPath.row])
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var model : CellViewAnyModel
        currentSectionType = sectionTypes[indexPath.row]
        
        switch currentSectionType {
            
        case .event:
            model = EventCollectionCellModel()
        case .people:
            model = PersonCollectionCellModel()
        }
        return collectionView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horBarLeftConstrint?.constant = scrollView.contentOffset.x / CGFloat(numberOfItems)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(row: index, section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        setTitileForIndex(indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch collectionView.indexPath(for: collectionView.visibleCells.first!) {
        case IndexPath(row: 0, section: 0):
            currentSectionType = .event
        case IndexPath(row: 1, section: 0):
        currentSectionType = .people
        default:
            print("Unknown cell")
        }
    }
    
    func scrollToMenuBarIndex(index: Int){
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right , animated: true)
        setTitileForIndex(index)
        
    }
    
    private func setTitileForIndex(_ index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "\(kpiTemplates[index].titleName)"
        }
        
    }
    
    
}

