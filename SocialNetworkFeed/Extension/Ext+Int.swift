//
//  Ext+Int.swift
//  SocialNetworkFeed
//
//  Created by admin on 7/7/2025.
//

import Foundation

extension Int {
    func stringValue() -> String {
        let num = abs(self)
        
        switch num {
        case 0..<1000:
            return "\(self)"
            
        case 1000..<1_000_000:
            let thousands = Double(num) / 1000.0
            let formatted = String(format: "%.1f", thousands)
                .replacingOccurrences(of: ".0", with: "")
            return "\(formatted) к"
            
        case 1_000_000...:
            let millions = Double(num) / 1_000_000.0
            let formatted = String(format: "%.1f", millions)
                .replacingOccurrences(of: ".0", with: "")
            return "\(formatted) м"
            
        default:
            return "\(self)"
        }
    }
}
