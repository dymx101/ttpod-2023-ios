//
//  SoundCloudApi.swift
//  TTPodMusicApp
//
//  Created by yiming on 21/10/23.
//

import Foundation
import Combine

final class SoundCloudApi {
  let session = URLSession(configuration: .default)

  private var cancellables = Set<AnyCancellable>()

  func fetchTracksByGenre(_ genre: String, offset: Int, limit: Int) async throws -> [SoundCloudTrack] {
    let urlString = SoundCloudApiConstant.tracksByGenreUrl(genre: genre, offset: offset, limit: limit)
    guard let url = URL(string: urlString) else { return [] }
    
    return try await withCheckedThrowingContinuation({ cont in
      session.dataTaskPublisher(for: url)
        .tryMap { element -> Data in
          guard let response = element.response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
            throw URLError(.badServerResponse)
          }
          return element.data
        }
        .decode(type: [SoundCloudTrack].self, decoder: JSONDecoder())
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .sink(
          receiveValue: { tracks in
            cont.resume(returning: tracks)
          }
        )
        .store(in: &cancellables)
    })
  }
}
