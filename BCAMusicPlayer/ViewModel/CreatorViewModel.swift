//
//  CreatorViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

class CreatorViewModel: ObservableObject {
    @Published var creators = [Creator]()
    @Published private var coverImages = [UIImage]()
    
    func loadAudios(){
        let group = DispatchGroup()
        // Grabbing podcasts data
        Firestore.firestore().collection("podcasts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
            
            for document in snapshot.documents {
                let name = document.data()["name"] as? String ?? "error"
                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                
                var image = UIImage(named: "trial-image")!
                let imageRef = storageRef.child("cover/\(document.data()["image"] as? String ?? "error").jpeg")
                
                group.enter() 
                
                imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                    defer {
                        group.leave()
                    }
                    
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                    } else if let data = data {
                        image = UIImage(data: data) ?? UIImage(named: "trial-image")!
                    }
                }
                
                group.notify(queue: .main) {
                    let episodes = document.data()["episodes"] as? [String: [String: Any]]
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
                    print(self.creators.last?.creatorImage)
                }
            }
        }
        
        // Grabbing artists data
        Firestore.firestore().collection("artists").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
            
            let group = DispatchGroup()
            
            for document in snapshot.documents {
                let name = document.data()["name"] as? String ?? "error"
                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                
                var image = UIImage(named: "trial-image")!
                let imageRef = storageRef.child("cover/\(document.data()["image"] as? String ?? "error").jpeg")
                
                group.enter()
                
                imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                    defer {
                        group.leave()
                    }
                    
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                    } else if let data = data {
                        image = UIImage(data: data) ?? UIImage(named: "trial-image")!
                    }
                }
                
                group.notify(queue: .main) {
                    let songs = document.data()["songs"] as? [String: [String: Any]]
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
            }
        }

    }
    
    func getAllAudios(searchText: String) -> [Audio]{
        return creators.flatMap { $0.getWorks }.filter { $0.audioName.localizedCaseInsensitiveContains(searchText) }
    }

    
}
