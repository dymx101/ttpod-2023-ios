//
//  MusicViewModel.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-30.
//

struct MusicModel: Identifiable, Codable {
    let id: String
    let title: String
    let artist: String
    let imageUrl: String
    let musicUrl: String
    let durationInSeconds: Int
}
