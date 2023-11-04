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
  @State var isLoading = false
  
  @Environment(\.safeAreaInsets) private var safeAreaInsets
  
  let gridItems: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 80)), count: 2)
  
  var body: some View {
    ZStack {
      Color.black
      GeometryReader { proxy in
        ScrollViewReader { reader in
          VStack {
            Color.clear
              .frame(height: safeAreaInsets.top)
            
            HStack {
              Text("Trending")
                .font(.title)
              Spacer()
            }
            .onTapGesture(count: 2) {
              guard let id = viewModel.tracks.first?.id else { return }
              withAnimation {
                reader.scrollTo(id, anchor: .top)
              }
            }

            ScrollView(showsIndicators: false) {
              LazyVGrid(columns: gridItems, spacing: 8) {
                ForEach(viewModel.tracks, id: \.id) { track in
                  ZStack {
                    VStack(alignment: .leading, spacing: 8) {
                      if let url = track.getArtworkUrl() {
                        WebImage(url: url)
                          .resizable()
                          .scaledToFill()
                          .frame(width: (proxy.size.width - 8 * 3) / 2)
                          .background(.black)
                      } else {
                        Image("default_album")
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
                          .padding(.bottom, 8)
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
                  .padding(.bottom, 8)
                }
              }
              
              if viewModel.shouldShowLoadMore {
                Text("Loading more data...")
                  .font(Font.system(size: 12))
                  .padding(.vertical, 8)
                  .onBecomingVisible {
                    Task {
                      await viewModel.fetchMore()
                    }
                  }
              }
              
              Color.clear
                .frame(height: safeAreaInsets.bottom + 55)
            }
          }
          .padding(.horizontal, 8)
        }
      }
      
      if isLoading {
        LoadingView(isAnimating: .constant(true), style: .large)
          .offset(y: -100)
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
        isLoading = true
#if DEBUG
        // To display the loading view
        try? await Task.sleep(nanoseconds: 1_000_000_000)
#endif
        await viewModel.fetchLocalMusics()
        isLoading = false
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MusicListView(viewModel: .init(api: .init()))
  }
}
