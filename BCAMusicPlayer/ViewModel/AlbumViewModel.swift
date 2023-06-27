//
//  AlbumViewModel.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import Foundation
import SwiftUI
import Firebase

class AlbumViewModel: ObservableObject {
    @Published var albums = [Album]()
    
    func loadAlbums(){
        print("loading albums")
        Firestore.firestore().collection("albums").getDocuments { snapshot, error in
            if(error == nil){
                for document in snapshot!.documents{
                    print("loading data")
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
                    print("Finish \(self.albums.count)")
                    
                    self.albums.append(Album(name: name, image: image, songs: songsArray))
                    
                    print("after \(self.albums.count)")
                    print(self.albums.first)
                }
            } else {
                print (error)
            }
        }
    }
}
