//
//  SafeArea.swift
//  TTPodMusicApp
//
//  Created by yiming on 3/11/23.
//

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
      guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
      }
      return (firstScene.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
