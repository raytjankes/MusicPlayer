//
//  SongListView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 08/07/23.
//

import SwiftUI

struct SongListView: View {
    @State private var songs: [Song] = []
    @State private var searchText = ""
    @State private var debouncedText = ""
    
    private let musicService: iTunesMusicServices = iTunesMusicAPI()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText, placeholder: "Search..", debouncedText: $debouncedText)
                if(songs.isEmpty){
                    Spacer()
                    Text("Songs not found")
                        .foregroundColor(Color.customDisabledButton)
                    Spacer()
                }
                else{
                    ScrollView{
                        
                        ForEach(songs, id: \.audioName) { song in
                            ItunesMusicItem(audio: song)
                        }
                    }
                }
                
            }
            .navigationTitle("Itunes Song List")
            .onAppear {
                fetchSongs()
            }
            .onChange(of: debouncedText) { _ in
                filterSongs()
            }
        }
    }
    
    private func fetchSongs() {
        // I can't do a top 100 songs the search term is a must, so I placed a top singer
        musicService.searchMusic(withTerm: "Benyamin Sueb") { result in
            switch result {
            case .success(let songs):
                DispatchQueue.main.async {
                    self.songs = songs
                                    }
            case .failure(let error):
                print("Error fetching songs: \(error)")
            }
        }
    }
    
    private func filterSongs() {
        if(debouncedText.isEmpty){
         fetchSongs()
        }
        else{
            musicService.searchMusic(withTerm: debouncedText) { result in
                switch result {
                case .success(let songs):
                    DispatchQueue.main.async {
                        self.songs = songs
                    }
                case .failure(let error):
                    print("Error fetching songs: \(error)")
                }
            }
        }

    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
