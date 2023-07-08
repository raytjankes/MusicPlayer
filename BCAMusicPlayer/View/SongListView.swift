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
    @State private var filteredSongs: [Song] = []
    
    private let musicService: iTunesMusicServices = iTunesMusicAPI()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText, placeholder: "Search..", debouncedText: $debouncedText)
                if(filteredSongs.isEmpty){
                    Spacer()
                    Text("Songs not found")
                        .foregroundColor(Color.customDisabledButton)
                    Spacer()
                }
                else{
                    List(filteredSongs, id: \.audioName) { song in
                        VStack(alignment: .leading) {
                            Text(song.audioName)
                                .font(.headline)
                            Text(song.getAudioGroup)
                                .font(.subheadline)
                        }
                    }
                }
                
            }
            .navigationTitle("Song List")
            .onAppear {
                fetchSongs()
            }
            .onChange(of: debouncedText) { _ in
                filterSongs(with: debouncedText)
            }
        }
    }
    
    private func fetchSongs() {
        musicService.searchMusic(withTerm: "Shawn Mendes") { result in
            switch result {
            case .success(let songs):
                DispatchQueue.main.async {
                    self.songs = songs
                    filterSongs(with: searchText)
                }
            case .failure(let error):
                print("Error fetching songs: \(error)")
            }
        }
    }
    
    private func filterSongs(with query: String) {
        if query.isEmpty {
            filteredSongs = songs
        } else {
            filteredSongs = songs.filter { song in
                song.audioName.localizedCaseInsensitiveContains(query) || song.getAudioGroup.localizedCaseInsensitiveContains(query)
            }
        }
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
