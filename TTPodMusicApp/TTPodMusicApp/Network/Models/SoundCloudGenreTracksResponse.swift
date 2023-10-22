//
//  SoundCloudGenreTracksResponse.swift
//  TTPodMusicApp
//
//  Created by yiming on 22/10/23.
//

import Foundation

struct SoundCloudChartsTrackResponse: Decodable {
    let genre: String
    let kind: String
    let lastUpdated: Date?
    let collection: [SoundCloudTrackCollection]
}
