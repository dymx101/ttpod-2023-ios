//
//  SoundCloudUser.swift
//  TTPodMusicApp
//
//  Created by yiming on 21/10/23.
//

import Foundation

struct SoundCloudUser: Decodable {
  let id: String
  let username: String?
  let avatar: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case username
    case avatar = "avatar_url"
  }
}
