//
//  ScrollableNaviBarDelegate.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/6/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

protocol ScrollableNaviBarDelegate {
    func showSearchVC()
    func hideSearchVC()
    func getResults(with query : String, results : [Searchable]?, error : String?)
}
