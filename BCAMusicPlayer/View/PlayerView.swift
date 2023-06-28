//
//  PlayerView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import AVFoundation

struct PlayerView: View {
    @EnvironmentObject var audioVM : AudioViewModel
    
    var body: some View {
        NavigationView{
        
        ZStack{
            Image(audioVM.creator.creatorImage).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer().frame(height: 20)
                Button {
                    audioVM.enlargePlayer = false
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.customHighlight.opacity(0.7))
                }
                Spacer().frame(height: 20)
                CreatorCard(creator: audioVM.creator, isWithText: true)
                Spacer()
                ZStack{
                    VStack{
                        Button {
                            audioVM.enlargePlayer = false
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.customHighlight.opacity(0.7))
                        }
                        Text(audioVM.audio.audioName)
                        HStack{
                            Button {
                                audioVM.previous()
                            } label: {
                                Image(systemName: "arrow.left.circle")
                                    .resizable()
                                    .foregroundColor(.black.opacity(0.2))
                            }.frame(width: 70,height: 70, alignment: .center)
                            Button {
                                audioVM.playPause()
                            } label: {
                                Image(systemName: audioVM.isPlaying ? "play.circle.fill" : "pause.circle.fill")
                                    .resizable()
                                    .foregroundColor(.blue)
                            }.frame(width: 70,height: 70, alignment: .center)
                            Button {
                                audioVM.next()
                            } label: {
                                Image(systemName: "arrow.right.circle")
                                    .resizable()
                                    .foregroundColor(.black.opacity(0.2))
                            }.frame(width: 70,height: 70, alignment: .center)
                        }
                    }
                    
                    

                }.edgesIgnoringSafeArea(.bottom)

            }
            
        }
        }
        .navigationBarHidden(true)
        .transition(.move(edge: .bottom))
    }
}



struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .environmentObject(AudioViewModel())
    }
}
