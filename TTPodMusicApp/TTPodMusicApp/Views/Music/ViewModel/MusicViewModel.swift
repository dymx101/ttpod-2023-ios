//
//  MusicViewModel.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-19.
//

import SwiftUI

class MusicViewModel: ObservableObject {
    
    // MARK: - Properties
    private let dataService = MusicService.shared
    
    @Published var musics : [MusicModel] = []
    @Published var selectedMusic: MusicModel?
    @Published var headerCategories: [String] = []
    
    init() {
        headerCategories = fetchCategories()
        fetchLocalMusics()
    }
    
    private func fetchCategories() -> [String] {
        return ["relax","energize","focus","workout","commute"]
    }
    
    // Local Data for test
    private func fetchLocalMusics() {
        musics = dataService.musics
    }
}
