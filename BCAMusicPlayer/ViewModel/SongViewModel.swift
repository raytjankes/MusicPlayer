//
//  SongViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation
import AVFoundation
import FirebaseStorage

class SongViewModel: ObservableObject {
    
    @Published var startedSong = false
    @Published var isPlaying = false
    @Published var player = AVPlayer()
    @Published var song : Song = Song(name: "dummy data", time: "dummy data", file: "dummy data")
    @Published var artist: Artist = Artist(name: "dummy data", image: "dummy data", songs: [Song(name: "dummy data", time: "dummy data", file: "dummy data")])
    
    func startSong(song: Song, artist: Artist){
        self.song = song
        self.artist = artist
        isPlaying = true
        startedSong = true
        playSong()
    }
    
    func playSong(){
        let storage = Storage.storage().reference(forURL : self.song.file)
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
    }
    
    func next(){
        if let currentIndex = artist.songs.firstIndex(of: song){
            if currentIndex == artist.songs.count - 1 {
                self.player.pause()
                song = artist.songs.first!
                self.playSong()
            }else{
                self.player.pause()
                song = artist.songs[currentIndex + 1]
                self.playSong()
            }
            
        }
        
    }
    
    func previous(){
        if let currentIndex = artist.songs.firstIndex(of: song){
            if currentIndex == 0{
                self.player.pause()
                song = artist.songs.last!
                self.playSong()
            }else{
                self.player.pause()
                song = artist.songs[currentIndex - 1]
                self.playSong()
            }
            
        }
        
    }
}
