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
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AudioViewModel())
                .environmentObject(CreatorViewModel())
        }
    }
}
