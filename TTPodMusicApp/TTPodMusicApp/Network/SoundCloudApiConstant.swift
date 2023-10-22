//
//  SoundCloudApiConstant.swift
//  TTPodMusicApp
//
//  Created by yiming on 21/10/23.
//

import Foundation

enum SoundCloudApiConstant {
  static let URL_API = "http://api.soundcloud.com/"
  static let URL_TOP_MUSIC = "https://itunes.apple.com/%1$s/rss/topsongs/limit=%2$s/json"
  static let FILTER_QUERY = "&q=%1$s"
  static let FILTER_GENRE = "&genres=%1$s"
  static let URL_API_V2 = "https://api-v2.soundcloud.com/"
  static let FORMAT_URL_SONG = "http://api.soundcloud.com/tracks/%1$s/stream?client_id=%2$s"
  
  static let URL_SEARCH_V2  = URL_API_V2 + "search/tracks"
  static let METHOD_CHARTS = "charts?"
  static let PARAMS_GENRES  = "&genre=soundcloud:genres:%1$s"
  static let PARAMS_LINKED_PARTITION = "&linked_partitioning=1"
  static let PARAMS_OFFSET  = "&offset=%1$s&limit=%2$s"
  static let PARAMS_KIND = "&kind=%1$s"
  static let PARAMS_NEW_CLIENT_ID = "&client_id=%1$s"
  static let KIND_TOP = "top"
  static let KIND_TRENDING = "trending"
  static let ALL_MUSIC_GENRE = "all-music"
  
  // 这两个client id都可以用
  // public static let SOUND_CLOUD_CLIENT_ID = "iZIs9mchVcX5lhVRyQGGAYlNPVldzAoX"
  static let SOUND_CLOUD_CLIENT_ID = "a3e059563d7fd3372b49b37f00a00bcf"
  
  static func tracksByGenreUrl(genre: String, offset: Int, limit: Int) -> String {
    "\(URL_API)tracks.json?client_id=\(SOUND_CLOUD_CLIENT_ID)&genres=\(genre)&offset=\(offset)&limit=\(limit)"
  }

  static func tracksByGenreUrlV2(genre: String, kind: String = KIND_TOP, offset: Int, limit: Int) -> String {
    "\(URL_API_V2)\(METHOD_CHARTS)&kind=\(kind)&client_id=\(SOUND_CLOUD_CLIENT_ID)&genre=soundcloud:genres:\(genre)&offset=\(offset)&limit=\(limit)&linked_partitioning=1"
  }
}
