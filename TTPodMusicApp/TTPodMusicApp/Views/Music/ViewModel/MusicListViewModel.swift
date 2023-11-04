//
//  MusicListViewModel.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-19.
//

import SwiftUI

class MusicListViewModel: ObservableObject {
  @Published var tracks : [SoundCloudTrack] = []

  // MARK: - Properties
  private let api: SoundCloudApi
  private var apiOffset = 0
  private let apiLimit = 20
  // TODO: make this genre configurable
  private var apiGenre = "Rock"

  private(set) var hasMoreData = true
  var shouldShowLoadMore: Bool { !tracks.isEmpty && hasMoreData }
  
  init(api: SoundCloudApi) {
    self.api = api
  }

  // Local Data for test
  @MainActor
  func fetchLocalMusics() async {
    // TODO: Error handling
    apiOffset = 0
    hasMoreData = true
    tracks = (try? await api.fetchTracksByGenreV2(apiGenre, offset: apiOffset, limit: apiLimit)) ?? []
    hasMoreData = !tracks.isEmpty
  }
  
  @MainActor
  func fetchMore() async {
    guard hasMoreData else { return }
    apiOffset += apiLimit
    let newTracks = (try? await api.fetchTracksByGenreV2(apiGenre, offset: apiOffset, limit: apiLimit)) ?? []
    tracks.append(contentsOf: newTracks)
    hasMoreData = !newTracks.isEmpty
  }
}
