//
//  Double.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-23.
//

import Foundation

extension Double {
    
    func asStringInMinute(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second, .nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
