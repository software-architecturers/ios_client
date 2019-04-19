//
//  CenterViewControllerDelegate.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 2/13/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

@objc
protocol MainCenterViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanel()
}
