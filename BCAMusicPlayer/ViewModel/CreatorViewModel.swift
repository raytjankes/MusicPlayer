//
//  CreatorViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation
import SwiftUI
import Firebase

class CreatorViewModel: ObservableObject {
    @Published var creators = [Creator]()
    
    func loadAudios(){
        // Grabbing artists data
        Firestore.firestore().collection("artists").getDocuments { snapshot, error in
            if(error == nil){
                for document in snapshot!.documents{
                    let name = document.data()["name"] as? String ?? "error"
                    let image = document.data()["image"] as? String ?? "error"
                    let songs = document.data()["songs"] as? [String : [String : Any]]
                    
                    var songsArray = [Song]()
                    if let songs = songs {
                        for song in songs {
                            let songName = song.value["name"] as? String ?? "error"
                            let songTime = song.value["time"] as? String ?? "error"
                            let songFile = song.value["file"] as? String ?? "error"
                            let songArtist = name
                            songsArray.append(Song(name: songName, time: songTime, file: songFile, artist: songArtist))
                        }
                    }
                    self.creators.append(Artist(name: name, image: image, songs: songsArray))
                }
            } else {
                print (error as Any)
            }
        }
        // Grabbing podcasts data
        Firestore.firestore().collection("podcasts").getDocuments { snapshot, error in
            if(error == nil){
                for document in snapshot!.documents{
                    let name = document.data()["name"] as? String ?? "error"
                    let image = document.data()["image"] as? String ?? "error"
                    let episodes = document.data()["episodes"] as? [String : [String : Any]]

                    var episodeArray = [Episode]()
                    if let episodes = episodes {
                        for episode in episodes {
                            let episodeName = episode.value["name"] as? String ?? "error"
                            let episodeTime = episode.value["time"] as? String ?? "error"
                            let episodeFile = episode.value["file"] as? String ?? "error"
                            let episodePodcast = name
                            episodeArray.append(Episode(name: episodeName, time: episodeTime, file: episodeFile, podcast: episodePodcast))
                        }
                    }
                    self.creators.append(Podcast(name: name, image: image, episodes: episodeArray))
                }
            } else {
                print (error as Any)
            }
        }
    }
    
    func getAllAudios(searchText: String) -> [Audio]{
        return creators.flatMap { $0.getWorks }.filter { $0.audioName.localizedCaseInsensitiveContains(searchText) }
    }
}
