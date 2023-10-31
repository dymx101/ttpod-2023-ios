//
//  Color.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-23.
//

import UIKit
import SwiftUI

extension UIColor {
    static let theme = ColorTheme()
    
    struct ColorTheme {
        let tabBarBackgroundColor = UIColor(named: "TabBarBackgroundColor")
        let appBackgroundColor = UIColor(named: "AppBackgroundColor")
    }
}

extension Color {
    static let theme = ColorTheme()
    struct ColorTheme {
        let tabBarBackgroundColor = Color("TabBarBackgroundColor")
        let appBackgroundColor = Color("AppBackgroundColor")
    }
}
