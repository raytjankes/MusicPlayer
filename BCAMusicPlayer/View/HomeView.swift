//
//  HomeView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var artistVM: ArtistViewModel
    @EnvironmentObject var songVM: SongViewModel
    @State var currentArtist : Artist?
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    SearchBarView(text: $searchText, placeholder: "Search..")
                    if(searchText.isEmpty){
                        
                        ScrollView{
                            ScrollView (.horizontal, showsIndicators: false, content: {
                                LazyHStack {
                                    if(artistVM.artists.first == nil){
                                        EmptyView()
                                    }
                                    else{
                                        ForEach(artistVM.artists, id:\.self) { artist in
                                            ArtistArt(artist: artist, isWithText: true).onTapGesture {
                                                self.currentArtist = artist
                                            }
                                            
                                        }
                                    }
                                    
                                }
                                
                            })
                            LazyVStack{
                                if(artistVM.artists.first == nil){
                                    EmptyView()
                                }
                                else{
                                    ForEach(self.currentArtist?.songs ?? artistVM.artists.first?.songs ?? [Song(name: "Song 1", time: "2:30" , file: ""),Song(name: "Song 1", time: "2:30", file: ""),Song(name: "Song 1", time: "2:30", file: ""),Song(name: "Song 1", time: "2:30", file: "")], id:\.self, content: { song in
                                        SongCell(song: song)
                                            .onTapGesture {
                                                songVM.startSong(song: song, artist: currentArtist ?? artistVM.artists.first!)
                                                print(songVM.isPlaying)
                                            }
                                    })
                                }
                                
                            }
                        }
                    } else {
                        ForEach(artistVM.getAllSongs(searchText: searchText), id:\.self, content: { song in
                            SongCell(song: song)
                                .onTapGesture {
                                    songVM.startSong(song: song, artist: currentArtist ?? artistVM.artists.first!)
                                    print(songVM.isPlaying)
                                }
                        })
                    }
                    Spacer()
                }
                if(songVM.startedSong == true){
                    VStack(){
                        Spacer()
                        MiniplayerView()
                    }
                }

            }
            .transition(.move(edge: .top))

        }
        .navigationBarHidden(true)
    }

}

struct ArtistArt:View{
    var artist :Artist
    var isWithText: Bool
    var body: some View {
        ZStack{
            Image(artist.image)
                .resizable()
            
            if isWithText == true{
                ZStack{
                    Text(artist.name).foregroundColor(.white)
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
        HomeView(artistVM: ArtistViewModel())
            .environmentObject(SongViewModel())
    }
}
