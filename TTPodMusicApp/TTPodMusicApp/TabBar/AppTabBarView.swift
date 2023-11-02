//
//  AppTabBarView.swift
//  TTPodMusicApp
//
//  Created by yiming on 30/9/23.
//

import Foundation
import SwiftUI

struct AppTabBarView: View {
  // MARK: -  属性
  @State private var selection: String = "home"
  @State private var tabSelection: TabBarItem = .home
  // MARK: -  内容
  var body: some View {
    CustomTabBarContainerView(selection: $tabSelection) {
      TTPodSettingsView()
        .tabBarItem(tab: .home, selection: $tabSelection)
      
      MusicListView(viewModel: .init(api: SoundCloudApi()))
        .tabBarItem(tab: .favorites, selection: $tabSelection)
      
      Color.green
        .tabBarItem(tab: .profile, selection: $tabSelection)
      
      Color.orange
        .tabBarItem(tab: .messages, selection: $tabSelection)
    }
  }
}

