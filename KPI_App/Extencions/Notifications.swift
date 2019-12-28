//
//  Notifications.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/26/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let showEventOnMap = Notification.Name("showEventOnMap")
    static let hideKeyboard = Notification.Name("hideKeyboard")
    static let navigateVC = Notification.Name("navigateVC")
    static let enterEvent = Notification.Name("enterEvent")
    
    static let nightModeEnabled = Notification.Name("nightModeEnabled")
    static let nightModeDisabled = Notification.Name("dayModeDisabled")
    
    static let sectionEntered = Notification.Name("sectionEntered")
}
