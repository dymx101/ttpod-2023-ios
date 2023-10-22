//
//  SoundCloudUser.swift
//  TTPodMusicApp
//
//  Created by yiming on 21/10/23.
//

import Foundation

struct SoundCloudUser: Decodable {
  let id: Int
  let username: String?
  let avatarUrl: String?
  let firstName: String?
  let lastName: String?
}
