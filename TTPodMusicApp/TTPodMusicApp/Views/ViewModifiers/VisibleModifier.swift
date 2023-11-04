//
//  VisibleModifier.swift
//  TTPodMusicApp
//
//  Created by yiming on 4/11/23.
//

import SwiftUI

public extension View {
  func onBecomingVisible(perform action: @escaping () -> Void) -> some View {
    modifier(BecomingVisible(action: action))
  }
}

private struct BecomingVisible: ViewModifier {
  
  @State var action: (() -> Void)?
  @State var wasVisible = false
  
  func body(content: Content) -> some View {
    content.overlay {
      GeometryReader { proxy in
        Color.clear
          .preference(
            key: VisibleKey.self,
            // See discussion!
            value: UIScreen.main.bounds.intersects(proxy.frame(in: .global))
          )
          .onPreferenceChange(VisibleKey.self) { isVisible in
            guard isVisible, !wasVisible, let action else {
              wasVisible = isVisible
              return
            }
            action()
            wasVisible = isVisible
          }
      }
    }
  }
  
  struct VisibleKey: PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) { }
  }
}
