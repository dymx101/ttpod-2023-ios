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
  let permalinkUrl: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case duration
    case title
    case artworkUrl = "artwork_url"
    case user
    case path
    case permalinkUrl = "permalink_url"
  }
  
  func getArtworkUrl() -> String? {
    return artworkUrl?.replacingOccurrences(of: "large", with: "crop")
  }
}
