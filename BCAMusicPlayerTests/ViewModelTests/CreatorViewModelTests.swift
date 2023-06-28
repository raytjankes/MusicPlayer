//
//  CreatorViewModelTests.swift
//  BCAMusicPlayerTests
//
//  Created by Ray on 28/06/23.
//

import Foundation
import XCTest

@testable import BCAMusicPlayer

@MainActor
class CreatorViewModelTests: XCTestCase {
    var sut: CreatorViewModel?
    
    override func setUpWithError() throws {
        super.setUp()
        sut = CreatorViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testLoadAudios() {
        // Call the loadAudios() method
        sut!.loadAudios()
        
        // Use expectations to wait for the async firebase operation to complete
        let expectation = XCTestExpectation(description: "Load audios")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Assuming the async operation duration
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10) // Increased from initial 3
        
        // Assert results
        if sut!.creators.isEmpty {
            XCTFail("No audios were loaded")
        } else {
            XCTAssertFalse(sut!.creators.isEmpty, "Audios should be loaded")
        }
    }
    
    func testGetAllAudios() {
        
        // Set test data
        let song1 = Song(name: "Song 1", time: "2:30", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Artist 1")
        let song2 = Song(name: "Song 2", time: "3:45", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Artist 1")
        let song3 = Song(name: "Song 3", time: "4:15", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Artist 1")
        
        let artist1 = Artist(name: "Artist 1", image: UIImage(named: "trial-image")!, songs: [song1, song2, song3])
        
        let song4 = Song(name: "Song 4", time: "3:20", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Artist 2")
        let song5 = Song(name: "Song 5", time: "4:10", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Artist 2")
        let song6 = Song(name: "Song 6", time: "2:50", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Artist 2")
        
        let artist2 = Artist(name: "Artist 2", image: UIImage(named: "trial-image")!, songs: [song4, song5, song6])
        
        let episode1 = Episode(name: "Episode 1", time: "15:30", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", podcast: "Podcast 1")
        let episode2 = Episode(name: "Episode 2", time: "20:15", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", podcast: "Podcast 1")
        let episode3 = Episode(name: "Episode 3", time: "10:45", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", podcast: "Podcast 1")
        
        let podcast1 = Podcast(name: "Podcast 1", image: UIImage(named: "trial-image")!, episodes: [episode1, episode2, episode3])
        
        let episode4 = Episode(name: "Episode 4", time: "25:20", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", podcast: "Podcast 2")
        let episode5 = Episode(name: "Episode 5", time: "18:10", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", podcast: "Podcast 2")
        let episode6 = Episode(name: "Episode 6", time: "12:50", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", podcast: "Podcast 2")
        
        let podcast2 = Podcast(name: "Podcast 2", image: UIImage(named: "trial-image")!, episodes: [episode4, episode5, episode6])
        
        let creators: [Creator] = [artist1, artist2, podcast1, podcast2]
        
        sut!.creators = creators
        
        // Call the getAllAudios() method
        let searchText = "Song"
        let audios = sut?.getAllAudios(searchText: searchText)
        
        // Assert results
        if let audios = audios {
            XCTAssertEqual(audios.count, 6, "Incorrect number of audios")
            XCTAssertTrue(audios.allSatisfy { $0.audioName.localizedCaseInsensitiveContains(searchText) }, "Audios should match the search text")
        } else {
            XCTFail("No audios were found")
        }
    }
}
