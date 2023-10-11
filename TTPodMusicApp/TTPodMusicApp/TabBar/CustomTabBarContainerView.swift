//
//  CustomTabBarContainerView.swift
//  TTPodMusicApp
//
//  Created by yiming on 30/9/23.
//

import Foundation
import SwiftUI

//自定义Tabbr全屏内容容器
struct CustomTabBarContainerView<Content:View>: View {
    //选中的tabbar模块
  @Binding var selection: TabBarItem
  //tabbar选项内容
  let content: Content
  //tabbar具体选项个数
  @State private var tabs: [TabBarItem] = []
  
  init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
    self._selection = selection
    self.content = content()
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
          //全屏内容
        content
        .ignoresSafeArea()
      //Tabbar选项容器
      CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
      } //: ZSTACK
    //通过preferenceKey和tabBarItem方法联动方式动态变化tabbar个数
    .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
      self.tabs = value
    }
  }
}

//预览代码
struct CustomTabBarContainerView_Previews: PreviewProvider {
  
  static let tabs: [TabBarItem] = [
    .home, .favorites, .profile, .messages
  ]
  
  static var previews: some View {
    CustomTabBarContainerView(selection: .constant(tabs.first!)) {
      Color.red
    }
  }
}

