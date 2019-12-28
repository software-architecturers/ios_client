//
//  ViewControllerExt.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/15/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
extension UIView{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

extension UIApplication {
    
    /// Dismiss keyboard from key window.
    /// Example Usage: `UIApplication.endEditing(true)`.
    ///
    /// - Parameters:
    ///     - force: specify `true` to force first responder to resign.
    open class func endEditing(_ force: Bool = false) {
        shared.keyWindow?.endEditing(force)
    }
}
