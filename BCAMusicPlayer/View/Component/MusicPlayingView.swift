//
//  MusicPlayingView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct MusicPlayingView: View {
    @ObservedObject var musicVM: MusicViewModel
        
    var body: some View {
        VStack {
            Text("Now Playing: \(musicVM.currentTrack)")
            
            HStack {
                Button(action: {
                    musicVM.restart()
                }) {
                    Image(systemName: "backward.end.fill")
                }
                
                if musicVM.isPlaying {
                    Button(action: {
                        musicVM.pause()
                    }) {
                        Image(systemName: "pause.fill")
                    }
                } else {
                    Button(action: {
                        musicVM.resume()
                    }) {
                        Image(systemName: "play.fill")
                    }
                }
                
                Button(action: {
                    musicVM.skip()
                }) {
                    Image(systemName: "forward.end.fill")
                }
            }
        }
        .padding()
    }
}

struct MusicPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayingView(musicVM: MusicViewModel())
    }
}
