//
//  SoundCloudApiDecoder.swift
//  TTPodMusicApp
//
//  Created by yiming on 22/10/23.
//

import Foundation

final class SoundCloudApiDecoder: JSONDecoder {
  override init() {
    super.init()
    keyDecodingStrategy = .convertFromSnakeCase
    dateDecodingStrategy = .iso8601
  }
}
