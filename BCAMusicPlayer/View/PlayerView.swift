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
    @EnvironmentObject var songVM : SongViewModel
    
    var body: some View {
        NavigationView{
        
        ZStack{
            Image(songVM.artist.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                ArtistArt(artist: songVM.artist, isWithText: false)
                Spacer()
                ZStack{
                    Color.white.cornerRadius(20).shadow(radius: 10)
                    VStack{
                        NavigationLink(destination: HomeView(artistVM: ArtistViewModel())) {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black.opacity(0.5))
                        }
                        Text(songVM.song.name)
                        HStack{
                            Button {
                                songVM.previous()
                            } label: {
                                Image(systemName: "arrow.left.circle")
                                    .resizable()
                                    .foregroundColor(.black.opacity(0.2))
                            }.frame(width: 70,height: 70, alignment: .center)
                            Button {
                                songVM.playPause()
                            } label: {
                                Image(systemName: songVM.isPlaying ? "play.circle.fill" : "pause.circle.fill")
                                    .resizable()
                                    .foregroundColor(.blue)
                            }.frame(width: 70,height: 70, alignment: .center)
                            Button {
                                songVM.next()
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
            .environmentObject(SongViewModel())
    }
}
