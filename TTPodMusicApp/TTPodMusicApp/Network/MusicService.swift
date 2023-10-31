//
//  MusicService.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-19.
//

import Foundation
import Combine

class MusicService {
    static let shared = MusicService()
    lazy var musics : [MusicModel] = []
    
    // 本地数据
    init() {
       fetch(forName: "musics")
    }
    
    private func fetch(forName fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([MusicModel].self, from: data)
                self.musics = jsonData
            } catch {
                print("DEBUG: parsing json error:\(error)")
            }
        }
    }
}
