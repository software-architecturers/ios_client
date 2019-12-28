//
//  MenuBar.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/5/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class MenuBar : UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    let imageSet = ["eventLogo","peopleLogo"]
    let cellId = "cellId"
    var horBarLeftConstrint : NSLayoutConstraint?
    var mainController : SearchViewController?
    var eventTemplates : [KpiTemplate]?
    let featuresHelper = CheckFeatures()
    lazy var numberOfItems = 2
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCollectionCell
        cell.imageView.image = UIImage(named: imageSet[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(numberOfItems), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainController?.scrollToMenuBarIndex(index: indexPath.item)
        
    }
    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 0.2307412326, blue: 0.3169002831, alpha: 1)
        return cv
    }()
    
    func setupHorizontalBar () {
        let horBarView = UIView()
        horBarView.backgroundColor = .white
        horBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horBarView)
        horBarLeftConstrint = horBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horBarLeftConstrint?.isActive = true
        horBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(numberOfItems)).isActive = true
        horBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuBarCollectionCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        collectionView.isScrollEnabled = false
        //collectionView.zeroConstraint(with: self)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndex = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .top)
        
        setupHorizontalBar()
        //        print(eventTemplates?.count)
        //        numberOfItems = eventTemplates?.count ?? 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

