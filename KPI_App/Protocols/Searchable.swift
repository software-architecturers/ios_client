//
//  Searchable.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/2/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

protocol Searchable {
}

protocol CellViewAnyModel {
    static var cellAnyType : UIView.Type {get}
    func setupAny(cell : UIView)
}

protocol CellViewModel : CellViewAnyModel {
    associatedtype CellType : UIView
    func setup(cell : CellType)
}

extension CellViewModel{
    func setupAny(cell: UIView) {
        setup(cell: cell as! CellType)
    }
    static var cellAnyType: UIView.Type {return CellType.self}
    
}
extension UITableView {
    func dequeueReusableCell (withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
        
        let indentifier = String(describing: type(of: model).cellAnyType)
        let cell = self.dequeueReusableCell(withIdentifier: indentifier, for: indexPath)
        model.setupAny(cell: cell)
        return cell
    }
    
    func register (models : [AnyClass]){
        for model in models {
            let indentifier = String(describing: model)
            self.register(model, forCellReuseIdentifier: indentifier)
        }
    }
}
extension UICollectionView {
    func dequeueReusableCell (withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UICollectionViewCell {
        
        let indentifier = String(describing: type(of: model).cellAnyType)
        let cell = self.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath)
        model.setupAny(cell: cell)
        return cell
    }
}
///////////////// SearchTableViewCells ////////////////
struct EventTableCellModel {
    let event : Event
}
extension EventTableCellModel : CellViewModel{
    func setup(cell: InterestEventCell) {
        cell.event = event
        cell.configureCell(with: event)
    }
}

struct PersonTableCellModel {
    let person : User
}
extension PersonTableCellModel : CellViewModel {
    
    func setup(cell: PersonSearchCell) {
        cell.person = person
        cell.configureCell(with: person)
    }
}

///////////////// SearchTableViewCells ////////////////



///////////////// SearchCollectionViewCells ////////////////

struct EventCollectionCellModel {
}
extension EventCollectionCellModel : CellViewModel{
    func setup(cell: EventTypeCollectionCell) {}
}

struct PersonCollectionCellModel {
}
extension PersonCollectionCellModel : CellViewModel {
    
    func setup(cell: PeopleTypeCollectionCell) {}
}

///////////////// SearchCollectionViewCells ////////////////





