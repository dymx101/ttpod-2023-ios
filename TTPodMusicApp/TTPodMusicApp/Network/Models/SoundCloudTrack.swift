//
//  SoundCloudTrack.swift
//  TTPodMusicApp
//
//  Created by yiming on 21/10/23.
//

import Foundation

struct SoundCloudTrack: Decodable {
  let id: Int
  let duration: Int?
  let title: String?
  private let artworkUrl: String?
  let user: SoundCloudUser?
  let path: String?
  let description: String?
  let genre: String?
  let labelName: String?
  let publisherMetadata: PublisherMetadata?
  
  func getArtworkUrl() -> URL? {
    guard let string =  artworkUrl?.replacingOccurrences(of: "large", with: "crop") else { return nil }
    return URL(string: string)
  }
  
  func getArtistName() -> String? {
    publisherMetadata?.artist ?? user?.username
  }
  
  struct PublisherMetadata: Decodable {
    let artist: String?
    let albumTitle: String?
    let releaseTitle: String?
  }
}
