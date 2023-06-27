//
//  MiniplayerView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import SwiftUI

struct MiniplayerView: View {
    @EnvironmentObject var songVM: SongViewModel
        
    var body: some View {
            NavigationLink(destination: PlayerView()) {
                VStack {
                    Text("Now Playing: \(songVM.song.name)")
                    
                    HStack {
                        Button(action: {
                            songVM.previous()
                        }) {
                            Image(systemName: "backward.end.fill")
                        }
                        
                        Button(action: {
                            songVM.playPause()
                            print(songVM.isPlaying)
                        }) {
                            Image(systemName: songVM.isPlaying ? "play.circle.fill" : "pause.circle.fill")
                        }

                        
                        Button(action: {
                            songVM.next()
                        }) {
                            Image(systemName: "forward.end.fill")
                        }
                    }
                }
                .padding()
            }
        
    }
}

struct MiniplayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniplayerView()
            .environmentObject(SongViewModel())
    }
}
