//
//  BCAMusicPlayerApp.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI
import Firebase

@main
struct BCAMusicPlayerApp: App {
    let data = DataViewModel()
    init() {
        FirebaseApp.configure()
        data.loadAlbums() //doesnt work
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LanguageViewModel())
        }
    }
}
