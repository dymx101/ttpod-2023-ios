//
//  GenreData.swift
//  TTPodMusicApp
//
//  Created by yiming on 4/11/23.
//

import Foundation

enum GenreData {
  static let json = """
[
  {
    "id": "1",
    "name": "EDM",
    "keyword": "danceedm",
    "img":"edm"
  },
  {
    "id": "2",
    "name": "Trap",
    "keyword": "trap",
    "img":"trap"
  },
  {
    "id": "3",
    "name": "Ambient",
    "keyword": "ambient",
    "img":"ambient"
  },
  {
    "id": "4",
    "name": "House",
    "keyword": "house",
    "img":"house"
  },
  {
    "id": "5",
    "name": "Dancehall",
    "keyword": "dancehall",
    "img":"dancehall"
  },
  {
    "id": "6",
    "name": "Deep House",
    "keyword": "deephouse",
    "img":"deephouse"
  },
  {
    "id": "7",
    "name": "Disco",
    "keyword": "disco",
    "img":"disco"
  },
  {
    "id": "8",
    "name": "Dubstep",
    "keyword": "dubstep",
    "img":"dubstep"
  },
  {
    "id": "9",
    "name": "Electronic",
    "keyword": "electronic",
    "img":"electro"
  },
  {
    "id": "10",
    "name": "Rap Hip hop",
    "keyword": "hiphoprap",
    "img":"hiphop"
  },
  {
    "id": "11",
    "name": "Jazz",
    "keyword": "jazzblues",
    "img":"jazz"
  },
  {
    "id": "12",
    "name": "Latin",
    "keyword": "latin",
    "img":"latin"
  },
  {
    "id": "13",
    "name": "Metal",
    "keyword": "metal",
    "img":"metal"
  },
  {
    "id": "14",
    "name": "Pop",
    "keyword": "pop",
    "img":"pop"
  },
  {
    "id": "15",
    "name": "R&B",
    "keyword": "rbsoul",
    "img":"rbsoul"
  },
  {
    "id": "16",
    "name": "Rock",
    "keyword": "rock",
    "img":"rock"
  }
]
"""
 
  static let data = json.data(using: .utf8)
  
  static let genres: [SoundCloudGenre] = {
    guard let data else { return [] }
    return (try? JSONDecoder().decode([SoundCloudGenre].self, from: data)) ?? []
  }()
  
  static func getRandomGenre() -> SoundCloudGenre? {
    genres.randomElement()
  }
}

struct SoundCloudGenre: Decodable {
  let id: String
  let name: String
  let keyword: String
  let img: String
}
