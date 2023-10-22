//
//  SoundCloudApiTests.swift
//  TTPodMusicAppTests
//
//  Created by yiming on 21/10/23.
//

import XCTest
@testable import TTPodMusicApp

final class SoundCloudApiTests: XCTestCase {
  
  let sut = SoundCloudApi()
  
  func testFetchTracks() async throws {
    let tracks = try await sut.fetchTracksByGenreV2("Rock", offset: 0, limit: 50)
    XCTAssertFalse(tracks.isEmpty)
  }
}
