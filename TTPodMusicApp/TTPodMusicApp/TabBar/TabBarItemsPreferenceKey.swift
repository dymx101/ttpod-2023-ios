//
//  TabBarItemsPreferenceKey.swift
//  TTPodMusicApp
//
//  Created by yiming on 30/9/23.
//

import Foundation
import SwiftUI

// MARK: -  创建 PreferenceKey
struct TabBarItemsPreferenceKey: PreferenceKey {
  
  static var defaultValue: [TabBarItem] = []
  
  static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
    value += nextValue()
  }
}

// MARK: -  创建Modifier
struct TabBarItemViewModifier: ViewModifier {
  let tab: TabBarItem
  @Binding var selection: TabBarItem
  
  func body(content: Content) -> some View {
    content
      .opacity(selection == tab ? 1.0 : 0.0)
      .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
  }
}

// MARK: -  扩展添加tabbar选项的方式
extension View {
  func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
    self
      .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
  }
}


