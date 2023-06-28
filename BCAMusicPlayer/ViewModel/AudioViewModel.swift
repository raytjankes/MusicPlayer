//
//  AudioViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation
import AVFoundation
import FirebaseStorage
import SwiftUI

class AudioViewModel: ObservableObject {
    @Published var enlargePlayer = false
    @Published var startedSong = false
    @Published var isPlaying = false
    @Published var player = AVPlayer()
    @Published var audio : Audio = Song(name: "dummy data", time: "dummy data", file: "dummy data", artist: "dummy data")
    @Published var creator: Creator = Artist(name: "dummy data", image: UIImage(named: "trial-image")!, songs: [Song(name: "dummy data", time: "dummy data", file: "dummy data", artist: "dummy data")])
    
    func startSong(audio: Audio, creator: Creator){
        self.audio = audio
        self.creator = creator
        isPlaying = true
        startedSong = true
        print("isPlaing: \(isPlaying)")
        playSong()
    }
    
    func playSong(){
        let storage = Storage.storage().reference(forURL : self.audio.audioFile)
        storage.downloadURL { (url, error) in
            if error != nil {
                print("error")
            }
            else{
                do{
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                }
                catch{
                    
                }
                self.player = AVPlayer(playerItem: AVPlayerItem(url: url!))
                self.player.play()
            }
        }
    }
    
    func playPause(){
        self.isPlaying.toggle()
        if self.isPlaying == true{
            player.pause()
        }else{
            player.play()
        }
        print("isPlaing: \(isPlaying)")
    }
    
    func next(){
        if let currentIndex = creator.getWorks.firstIndex(of: audio){
            if currentIndex == creator.getWorks.count - 1 {
                self.player.pause()
                audio = creator.getWorks.first!
                self.playSong()
            }else{
                self.player.pause()
                audio = creator.getWorks[currentIndex + 1]
                self.playSong()
            }
            
        }
        
    }
    
    func previous(){
        if let currentIndex = creator.getWorks.firstIndex(of: audio){
            if currentIndex == 0{
                self.player.pause()
                audio = creator.getWorks.last!
                self.playSong()
            }else{
                self.player.pause()
                audio = creator.getWorks[currentIndex - 1]
                self.playSong()
            }
            
        }
        
    }
}
