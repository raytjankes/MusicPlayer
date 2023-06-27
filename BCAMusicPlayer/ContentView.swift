//
//  ContentView.swift
//  BCAMusicPlayer
//
//  Created by Ray on 26/06/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    let artistVM = ArtistViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                HomeView(artistVM: artistVM)
            }
            .onAppear {
                artistVM.loadAlbums()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SongViewModel())
    }
}
