//
//  HomeView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var albumVM: AlbumViewModel
    @State var songVM: SongViewModel = SongViewModel()
    @State var currentAlbum : Album?
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    ScrollView (.horizontal, showsIndicators: false, content: {
                        LazyHStack {
                            if(albumVM.albums.first == nil){
                                EmptyView()
                            }
                            else{
                                ForEach(albumVM.albums, id:\.self) { album in
                                    AlbumArt(album: album, isWithText: true).onTapGesture {
                                        self.currentAlbum = album
                                    }
                                    
                                }
                            }

                        }
                        
                    })
                    LazyVStack{
                        if(albumVM.albums.first == nil){
                            EmptyView()
                        }
                        else{
                            ForEach(self.currentAlbum?.songs ?? albumVM.albums.first?.songs ?? [Song(name: "Song 1", time: "2:30" , file: ""),Song(name: "Song 1", time: "2:30", file: ""),Song(name: "Song 1", time: "2:30", file: ""),Song(name: "Song 1", time: "2:30", file: "")], id:\.self, content: { song in
                                SongCell(album: (currentAlbum ?? albumVM.albums.first!), song: song)
                                    .onTapGesture {
                                        songVM.startSong(song: song, album: currentAlbum ?? albumVM.albums.first!)
                                        print(songVM.isPlaying)
                                    }
                            })
                        }
                        
                    }
                }
                if(songVM.isPlaying == true){
                    VStack(){
                        Spacer()
                        MiniplayerView(songVM: $songVM)
                    }
                    .background(.black)
                }

            }

        }
        .onAppear {
            albumVM.loadAlbums()
        }
    }

}

struct AlbumArt:View{
    var album :Album
    var isWithText: Bool
    var body: some View {
        ZStack{
            Image(album.image)
                .resizable()
            
            if isWithText == true{
                ZStack{
                    Text(album.name).foregroundColor(.white)
                }
            }

        }
        .frame(width: 170, height: 200, alignment: .center)
        .clipped()
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(20)
    }
}

struct SongCell : View{
    var album: Album
    var song: Song
    var body: some View {
            VStack{
                HStack{
                    Image(systemName: "opticaldisc.fill").resizable().frame(width: 60, height: 60, alignment: .center)
                        .foregroundColor(.blue)
                    Text(song.name)
                    Spacer()
                    Text(song.time)
                }
                .padding(.vertical)
                Divider()
            }.padding(.horizontal)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(albumVM: AlbumViewModel())
    }
}
