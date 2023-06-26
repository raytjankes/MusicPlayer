//
//  ContentView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var musicVM = MusicViewModel()
    @State private var showSplash = true
    
    var body: some View {
        NavigationView{
            VStack {
                if showSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    MusicListView(musicVM: musicVM)
                    MusicPlayingView(musicVM: musicVM)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
