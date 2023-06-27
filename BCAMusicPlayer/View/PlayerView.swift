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
    @Binding var songVM : SongViewModel
    
    var body: some View {
        ZStack{
            Image(songVM.album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                AlbumArt(album: songVM.album, isWithText: false)
                Spacer()
                Text(songVM.song.name)
                Spacer()
                ZStack{
                    Color.white.cornerRadius(20).shadow(radius: 10)
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
                    

                }.edgesIgnoringSafeArea(.bottom)

            }
            
        }
    }
}



struct PlayerView_Previews: PreviewProvider {
    @State static var songVM = SongViewModel()
    static var previews: some View {
        PlayerView(songVM: $songVM)
    }
}
