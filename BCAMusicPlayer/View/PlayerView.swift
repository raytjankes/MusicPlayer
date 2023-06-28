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
            Image(uiImage: audioVM.creator.creatorImage).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Button {
                    audioVM.enlargePlayer = false
                } label: {
                    Image(systemName: "chevron.compact.down")
                        .resizable()
                        .frame(width: 40, height: 20)
                        .foregroundColor(Color.customHighlight.opacity(0.7))
                }
                Spacer().frame(height: 20)
                CreatorCard(creator: audioVM.creator, isPlayer: true)
                Text(audioVM.audio.audioName)
                    .foregroundColor(Color.customHighlight)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .padding(.bottom)
                Text(audioVM.audio.getAudioGroup)
                    .foregroundColor(Color.customHighlight)
                    .font(.system(size: 15))
                Spacer()
                ZStack{
                    VStack{
                        HStack{
                            Button {
                                audioVM.previous()
                            } label: {
                                Image(systemName: "chevron.left.2")
                                    .resizable()
                                    .foregroundColor(Color.customHighlight.opacity(0.7))
                            }.frame(width: 30,height: 30, alignment: .center)
                            Button {
                                audioVM.playPause()
                            } label: {
                                Image(systemName: audioVM.isPlaying ? "play.circle.fill" : "pause.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.customHighlight.opacity(0.85))
                            }.frame(width: 70,height: 70, alignment: .center)
                                .padding(.horizontal)
                            Button {
                                audioVM.next()
                            } label: {
                                Image(systemName: "chevron.right.2")
                                    .resizable()
                                    .foregroundColor(Color.customHighlight.opacity(0.7))
                            }.frame(width: 30,height: 30, alignment: .center)
                        }
                    }
                    
                    

                }.edgesIgnoringSafeArea(.bottom)

            }
            .padding(.bottom)

            
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
