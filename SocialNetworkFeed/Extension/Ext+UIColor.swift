//
//  Ext+UIColor.swift
//  SocialNetworkFeed
//
//  Created by admin on 6/7/2025.
//

import UIKit

extension UIColor {
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
    static func themeColor(light: UIColor, dark: UIColor) -> UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                    return traitCollection.userInterfaceStyle == .dark ? dark : light
                }
            } else {
                return light
            }
        }
    
}
