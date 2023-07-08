//
//  HomeView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var creatorVM: CreatorViewModel
    @EnvironmentObject var audioVM: AudioViewModel
    @State var currentArtist : Creator?
    @State private var searchText = ""
    @State private var displayText = ""
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    SearchBarView(text: $displayText, placeholder: "Search..", debouncedText: $searchText)
                    if(searchText.isEmpty){
                        
                        ScrollView{
                            VStack{
                                HStack{
                                    Text("Creators")
                                        .foregroundColor(Color.customText)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                GeometryReader { geometry in
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color.customDisabledButton.opacity(0.4))
                                    .padding(.trailing, geometry.size.width * 0.2)                               }
                                
                            }
                            
                            ScrollView (.horizontal, showsIndicators: false, content: {
                                LazyHStack {
                                    if(creatorVM.creators.first == nil){
                                        EmptyView()
                                    }
                                    else{
                                        ForEach(creatorVM.creators, id:\.self) { creator in
                                            CreatorCard(creator: creator, isPlayer: false)
                                                .onTapGesture {
                                                    self.currentArtist = creator
                                                    
                                                }
                                            
                                        }
                                    }
                                    
                                }
                                
                            })
                            
                            VStack{
                                HStack{
                                    Text("Audios")
                                        .foregroundColor(Color.customText)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                GeometryReader { geometry in
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color.customDisabledButton.opacity(0.4))
                                        .padding(.trailing, geometry.size.width * 0.2)
                                }
                                
                            }
                            
                            LazyVStack{
                                if(creatorVM.creators.first == nil){
                                    EmptyView()
                                }
                                else{
                                    ForEach(self.currentArtist?.getWorks ?? creatorVM.creators.first?.getWorks ?? [Audio(name: "Song 1", time: "2:30" , file: "")], id:\.self, content: { audio in
                                        AudioItem(audio: audio)
                                            .onTapGesture {
                                                audioVM.startSong(audio: audio, creator: currentArtist ?? creatorVM.creators.first!)
                                                print(audioVM.isPlaying)
                                            }
                                    })
                                }
                                
                            }
                        }
                    } else {
                        ScrollView{
                            ForEach(creatorVM.getAllAudios(searchText: searchText), id:\.self, content: { audio in
                                AudioItem(audio: audio)
                                    .onTapGesture {
                                        audioVM.startSong(audio: audio, creator: currentArtist ?? creatorVM.creators.first!)
                                    }
                            })
                        }
                    }
                    Spacer()
                }
                
                if(audioVM.startedSong == true){
                    VStack{
                        Spacer()
                        MiniplayerView()
                            
                    }.ignoresSafeArea()

                }
                
            }
            
        }
        .navigationBarHidden(true)
    }
    
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AudioViewModel())
            .environmentObject(CreatorViewModel())
    }
}
