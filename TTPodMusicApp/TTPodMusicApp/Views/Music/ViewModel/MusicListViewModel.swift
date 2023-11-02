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
  
  init(api: SoundCloudApi) {
    self.api = api
  }

  // Local Data for test
  @MainActor
  func fetchLocalMusics() async {
    // TODO: make this genre configurable
    // TODO: Error handling
    // TODO: load more
    tracks = (try? await api.fetchTracksByGenreV2("Rock", offset: 0, limit: 50)) ?? []
  }
}
