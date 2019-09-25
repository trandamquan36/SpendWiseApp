//
//  Colors.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 2/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    static func getColor(redColor: Float, greenColor: Float, blueColor: Float, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(redColor)/255.0,
                       green: CGFloat(greenColor)/255.0,
                       blue: CGFloat(blueColor)/255.0,
                       alpha: CGFloat(alpha))
    }
}
