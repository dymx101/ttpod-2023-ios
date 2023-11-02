//
//  ContentView.swift
//  TTPodMusicApp
//
//  Created by yiming on 20/9/23.
//

import SwiftUI
import SDWebImageSwiftUI

// https://img.sj33.cn/uploads/allimg/200909/10_2001.jpg
struct MusicListView: View {
  @ObservedObject var viewModel: MusicListViewModel
  @State var selectedMusic : MusicModel? = nil
  @State private var isExpanded = false
  @State var loading = false
  
  let gridItems: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 80)), count: 2)
  
  var body: some View {
    ZStack {
      Color.black
      GeometryReader { proxy in
        ScrollView {
          LazyVGrid(columns: gridItems, spacing: 8) {
            ForEach(viewModel.tracks, id: \.id) { track in
              ZStack {
                VStack(alignment: .leading, spacing: 8) {
                  if let url = track.getArtworkUrl() {
                    WebImage(url: url)
                      .resizable()
                      .scaledToFill()
                      .frame(width: (proxy.size.width - 8) / 2)
                      .background(.black)
                  } else {
                    Image(systemName: "heart.fill")
                      .resizable()
                      .scaledToFill()
                      .background(.black)
                  }
                  Group {
                    Text(track.title ?? "Unknown Music")
                      .font(.headline)
                      .lineLimit(3)
                      .multilineTextAlignment(.leading)
                    Text(track.user?.username ?? "UnKnown User")
                      .font(.subheadline)
                      .lineLimit(2)
                      .multilineTextAlignment(.leading)
                  }
                  .padding(.horizontal, 8)
                }
                .onTapGesture {
                  print("tap one music")
//                  if selectedMusic == nil {
//                    selectedMusic = viewModel.musics[0]
//                  } else {
//                    isExpanded.toggle()
//                  }
                }
              }
              .background(.white.opacity(0.1))
              .foregroundColor(.white)
              .cornerRadius(4)
            }
          }
        }
      }
      VStack {
        Spacer()
        TTPodPlayMusicView(selectedMusic: $selectedMusic, isExpanded: $isExpanded)
          .padding(.bottom,7)
          .environmentObject(viewModel)
          .opacity(selectedMusic == nil ? 0 : 1)
      }
      .ignoresSafeArea()
    }
    .ignoresSafeArea()
    .onAppear {
      Task { @MainActor in
        loading = true
        await viewModel.fetchLocalMusics()
        loading = false
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MusicListView(viewModel: .init(api: .init()))
  }
}
