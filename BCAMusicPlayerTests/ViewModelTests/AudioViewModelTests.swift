//
//  AudioViewModelTests.swift
//  BCAMusicPlayerTests
//
//  Created by Ray on 28/06/23.
//

import Foundation
import XCTest

@testable import BCAMusicPlayer

@MainActor
class AudioViewModelTests: XCTestCase {
    var sut: AudioViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = AudioViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testStartSong() {
        // Set up test data
        let song = Song(name: "Test Song", time: "2:30", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let artist = Artist(name: "Test Artist", image: UIImage(named: "trial-image")!, songs: [song])
        
        // Call the startSong() method
        sut.startSong(audio: song, creator: artist)
        
        // Assert results
        XCTAssertTrue(sut.isPlaying, "Song should be playing")
        XCTAssertTrue(sut.startedSong, "Song should be started")
        XCTAssertEqual(sut.audio, song, "Incorrect song set")
        XCTAssertEqual(sut.creator, artist, "Incorrect artist set")
    }
    
    func testPlayPause() {
        // Set playing state
        sut.isPlaying = true
        
        // Call the method
        sut.playPause()
        
        // Assert the results
        XCTAssertFalse(sut.isPlaying, "Song should be paused")
        
        // Simulate paused state
        sut.isPlaying = false
        
        // Call the method again
        sut.playPause()
        
        // Assert results
        XCTAssertTrue(sut.isPlaying, "Song should be playing")
    }
    
    func testPrevious() {
        // Set up test data
        let song1 = Song(name: "Song 1", time: "2:30", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let song2 = Song(name: "Song 2", time: "3:45", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let song3 = Song(name: "Song 3", time: "4:15", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let artist = Artist(name: "Test Artist", image: UIImage(named: "trial-image")!, songs: [song1, song2, song3])
        
        // Set initial song
        sut.audio = song2
        sut.creator = artist
        
        // Call the method
        sut.previous()
        
        // Assert results
        XCTAssertEqual(sut.audio, song1, "Incorrect song set")
        
        // Call the previous() method again
        sut.previous()
        
        // Assert results
        XCTAssertEqual(sut.audio, song3, "Incorrect song set")
        
        // Reach the first song
        sut.previous()
        
        // Assert results
        XCTAssertEqual(sut.audio, song2, "Incorrect song set")
    }
    

    
    func testNext() {
        // Set up test data
        let song1 = Song(name: "Song 1", time: "2:30", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let song2 = Song(name: "Song 2", time: "3:45", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let song3 = Song(name: "Song 3", time: "4:15", file: "gs://musicplayer-5492d.appspot.com/songs/Runtuh.mp3", artist: "Test Artist")
        let artist = Artist(name: "Test Artist", image: UIImage(named: "trial-image")!, songs: [song1, song2, song3])
        
        // Set initial song
        sut.audio = song1
        sut.creator = artist
        
        // Call the method
        sut.next()
        
        // Assert results
        XCTAssertEqual(sut.audio, song2, "Incorrect song set")
        
        // Call the next() method again
        sut.next()
        
        // Assert results
        XCTAssertEqual(sut.audio, song3, "Incorrect song set")
        
        // Reach the last song
        sut.next()
        
        // Assert results
        XCTAssertEqual(sut.audio, song1, "Incorrect song set")
    }
    
}
