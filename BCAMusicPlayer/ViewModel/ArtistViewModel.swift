//
//  ArtistViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation
import SwiftUI
import Firebase

class ArtistViewModel: ObservableObject {
    @Published var artists = [Artist]()
    
    func loadAlbums(){
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
                            songsArray.append(Song(name: songName, time: songTime, file: songFile))
                        }
                    }
                    self.artists.append(Artist(name: name, image: image, songs: songsArray))
                }
            } else {
                print (error)
            }
        }
    }
    
    func getAllSongs(searchText: String) -> [Song]{
        return artists.flatMap { $0.songs }.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
