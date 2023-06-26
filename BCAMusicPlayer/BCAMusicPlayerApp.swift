//
//  BCAMusicPlayerApp.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

@main
struct BCAMusicPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LanguageViewModel())
        }
    }
}
