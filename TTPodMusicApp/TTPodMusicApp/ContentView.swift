//
//  ContentView.swift
//  TTPodMusicApp
//
//  Created by yiming on 20/9/23.
//

import SwiftUI

// https://img.sj33.cn/uploads/allimg/200909/10_2001.jpg
struct ContentView: View {
    @State var selectedMusic : MusicModel? = nil
    @State private var isExpanded = false
    @StateObject var viewModel = MusicViewModel()
    
  let gridItems: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 80)), count: 2)
  
    var body: some View {
      ZStack {
        Color.black
        GeometryReader { proxy in
          ScrollView {
            LazyVGrid(columns: gridItems, spacing: 8) {
              ForEach(1..<100, id: \.self) { number in
                ZStack {
                  VStack(alignment: .leading, spacing: 8) {
                    Image(systemName: "heart.fill")
                      .resizable()
                      .scaledToFill()
                      .background(.green)
                    Group {
                      Text("歌曲名 - 歌曲名歌曲名歌曲名歌曲名")
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                      Text("歌手歌手歌手")
                        .font(.subheadline)
                        .lineLimit(1)
                    }
                    .padding(.horizontal, 8)
                  }
                  .onTapGesture {
                      print("tap one music")
                      if selectedMusic == nil {
                          selectedMusic = viewModel.musics[0]
                      } else {
                          isExpanded.toggle()
                      }
                  }
                }
                .frame(width: (proxy.size.width - 8) / 2)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
