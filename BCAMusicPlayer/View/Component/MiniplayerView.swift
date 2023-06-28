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
        HStack{
            Spacer()
            VStack {
                Button {
                    songVM.enlargePlayer = true
                } label: {
                    Image(systemName: "chevron.compact.up")
                        .resizable()
                        .foregroundColor(Color.customDisabledButton)
                        .frame(width: 20, height: 10)
                }.fullScreenCover(isPresented: $songVM.enlargePlayer) {
                    PlayerView()
                        .ignoresSafeArea()
                }
                Spacer().frame(height: 15)

                Text("Now Playing: \(songVM.audio.audioName)")
                
                HStack {
                    Button(action: {
                        songVM.previous()
                    }) {
                        Image(systemName: "chevron.left.2")
                            .resizable()
                            .foregroundColor(Color.customSecondary.opacity(0.85))
                    }
                    .frame(width: 20, height: 20)
                    
                    Button(action: {
                        songVM.playPause()
                        print(songVM.isPlaying)
                    }) {
                        Image(systemName: songVM.isPlaying ? "play.circle.fill" : "pause.circle.fill")
                            .resizable()
                            .foregroundColor(Color.customSecondary)
                    }
                    .frame(width: 30, height: 30)
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        songVM.next()
                    }) {
                        Image(systemName: "chevron.right.2")
                            .resizable()
                            .foregroundColor(Color.customSecondary.opacity(0.85))
                    }
                    .frame(width: 20, height: 20)
                }
                .padding(.bottom)
            }
            Spacer()
        }
  
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(Color.customHighlight)
                .shadow(radius: 10)
        )
        .edgesIgnoringSafeArea(.all)

    }
        
}

struct MiniplayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniplayerView()
            .environmentObject(AudioViewModel())
    }
}
