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
    @State private var showSplash = true
    @EnvironmentObject var artistVM : CreatorViewModel
    
    var body: some View {
        NavigationView{
            ZStack{
                if showSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    NavigationView {
                        HomeView()
                    }
                    
                }
            }.onAppear {
                artistVM.loadAudios()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioViewModel())
            .environmentObject(CreatorViewModel())
    }
}
