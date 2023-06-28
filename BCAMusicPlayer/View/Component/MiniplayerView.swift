//
//  MiniplayerView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 27/06/23.
//

import SwiftUI

struct MiniplayerView: View {
    @EnvironmentObject var songVM: AudioViewModel
        
    var body: some View {
        
        VStack {
            Button {
                songVM.enlargePlayer = true
            } label: {
                Image(systemName: "chevron.up")
            }.fullScreenCover(isPresented: $songVM.enlargePlayer) {
                PlayerView()
                    .ignoresSafeArea()
            }

            Text("Now Playing: \(songVM.audio.audioName)")
            
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
        
    }
        
}

struct MiniplayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniplayerView()
            .environmentObject(AudioViewModel())
    }
}
