//
//  Data.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 5/15/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class Device {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func safeHeight(with view : UIView) -> CGFloat{
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        return height
    }
    static func safeWidth(with view : UIView) -> CGFloat{
        let guide = view.safeAreaLayoutGuide
        let width = guide.layoutFrame.size.width
        return width
    }
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    static func naviBarHeight(with vc : UIViewController) -> CGFloat{
        if let nvHeight = vc.navigationController?.navigationBar.frame.height{
            return nvHeight + self.statusBarHeight
        }
        return 0
        
    }
}
