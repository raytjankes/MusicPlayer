//
//  MusicViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import Foundation
import AVFoundation

class MusicViewModel: NSObject, ObservableObject {
    @Published var isPlaying = false
    @Published var currentTrack: String = ""
    
    private var player: AVPlayer?
    
    func playTrack(named trackName: String, fromURL url: URL) {
        player = AVPlayer(url: url)
        player?.play()
        
        print("Attempting to play track: \(trackName)")
        print("URL: \(url)")
        
        currentTrack = trackName
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func resume() {
        player?.play()
        isPlaying = true
    }
    
    func skip() {
        // Implement your logic to skip to the next track
    }
    
    func restart() {
        // Implement your logic to restart the current track
    }
}
