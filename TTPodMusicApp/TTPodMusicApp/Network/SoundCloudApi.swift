//
//  SoundCloudApi.swift
//  TTPodMusicApp
//
//  Created by yiming on 21/10/23.
//

import Foundation
import Combine
import SwiftSoup

final class SoundCloudApi {
  let session = URLSession(configuration: .default)

  private var cancellables = Set<AnyCancellable>()
  
  func fetchTracksByGenreV2(_ genre: String, offset: Int, limit: Int) async throws -> [SoundCloudTrack] {
    let urlString = SoundCloudApiConstant.tracksByGenreUrlV2(genre: genre, offset: offset, limit: limit)
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
        .decode(type: SoundCloudChartsTrackResponse.self, decoder: SoundCloudApiDecoder())
        .map { response in response.collection.map { $0.track } }
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { error in
          print(error)
        },
          receiveValue: { tracks in
            cont.resume(returning: tracks)
          }
        )
        .store(in: &cancellables)
    })
  }
  
  func fetchPlaybackUrl(by trackId: Int64?) async throws -> String? {
    guard let trackId else { return nil }
    
    let apiUrl = "https://api.soundcloud.com/tracks/\(trackId)"
    guard let encodedApiUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
    
    let wapUrlString = "https://w.soundcloud.com/player/?url=\(encodedApiUrl)"
    guard let wapUrl = URL(string: wapUrlString) else { return nil }

    // fetch cotent of the webpage
    var response = try await session.data(from: wapUrl)

    guard let html = String(data: response.0, encoding: .utf8),
            let doc: Document = try? SwiftSoup.parse(html) else { return nil }
    
    guard let link = try doc.select("link[rel=\"canonical\"]").first()?.attr("abs:href"),
          let encodedLink = link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
    
    let apiV2UrlString = "\(SoundCloudApiConstant.URL_API_V2)resolve?url=\(encodedLink)&client_id=\(SoundCloudApiConstant.SOUND_CLOUD_CLIENT_ID)"
    guard let apiV2Url = URL(string: apiV2UrlString) else { return nil }
    
    // Fetch api data
    response = try await session.data(from: apiV2Url)
    let model = try JSONDecoder().decode(TrackModelForParsing.self, from: response.0)
    
    guard let transcoding = model.media?.transcodings?.first(where: { $0.isValid }),
            let url = transcoding.url else { return nil }
    
    let apiStreamUrlString = "\(url)?client_id=\(SoundCloudApiConstant.SOUND_CLOUD_CLIENT_ID)"
    guard let apiStreamUrl = URL(string: apiStreamUrlString) else { return nil }
    // fetch data from the extracted stream url
    response = try await session.data(from: apiStreamUrl)
    let streamUrl = try JSONDecoder().decode(StreamUrl.self, from: response.0)

    return streamUrl.url
  }
}

private struct TrackModelForParsing: Decodable {
  let media: Media?
  
  struct Media: Decodable {
    let transcodings: [TransCoding]?
  }
  
  struct TransCoding: Decodable {
    let url: String?
    let preset: String?
    let duration: Int?
    let snipped: Bool?
    let quality: String?
    let format: Format?
    
    var isValid: Bool {
      guard let preset else { return false }
      return preset.contains(PresentKeyword.opus.rawValue) ||
      preset.contains(PresentKeyword.mp3.rawValue) && format?.protocol == ProtocolType.progressive.rawValue
    }
  }
  
  struct Format: Decodable {
    let `protocol`: String?
    let mime_type: String?
  }
  
  enum PresentKeyword: String {
    case mp3
    case opus
  }
  
  enum ProtocolType: String {
    case progressive
  }
}

struct StreamUrl: Decodable {
  let url: String?
}
