//
//  MusicListView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI

struct MusicListView: View {
    @EnvironmentObject var language: LanguageViewModel
    let tracks = [
        ("Runtuh", Bundle.main.url(forResource: "Runtuh", withExtension: "mp3")!),
        ("Track 2", URL(string: "https://example.com/track2.mp3")!),
        ("Track 3", URL(string: "https://example.com/track3.mp3")!)
    ] // Replace with your own track names and URLs
    
    @ObservedObject var musicVM: MusicViewModel
    @State private var searchText = ""
    @State private var filteredTracks: [(String, URL)] = []
    
    var body: some View {
        VStack {
            SearchBarView(text: $searchText, placeholder: "Search")
                .padding(.horizontal)
            
            List(filteredTracks, id: \.0) { track in
                Button(action: {
                    musicVM.playTrack(named: track.0, fromURL: track.1)
                }) {
                    Text(track.0)
                }
            }
        }
        .onChange(of: searchText) { searchText in
            filterTracks()
        }
        .onAppear {
            filteredTracks = tracks
        }
    }
    
    private func filterTracks() {
        if searchText.isEmpty {
            filteredTracks = tracks
        } else {
            filteredTracks = tracks.filter { track in
                track.0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}



struct MusicListView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListView(musicVM: MusicViewModel())
            .environmentObject(LanguageViewModel())
    }
}
